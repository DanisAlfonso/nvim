-- translate.lua
-- Traduce texto con llm + DeepSeek V4 desde Neovim
--
-- Escenarios:
--   1. Modo normal: palabra bajo el cursor → traducción en hover flotante
--   2. Modo visual: selección → traducción en hover flotante
--   3. Reemplazar: como los anteriores pero sustituye el texto original
--   4. Escribiendo: seleccionas / escribes y traduces al vuelo
--   5. Rango: :TraduceES 5,10 → traduce líneas 5 a 10
--
-- Keymaps (modo normal y visual):
--   <leader>te    → traduce al español (flotante)
--   <leader>ti    → traduce al inglés (flotante)
--   <leader>td    → traduce al alemán (flotante)
--   <leader>tE    → reemplaza por español
--   <leader>tI    → reemplaza por inglés
--   <leader>tD    → reemplaza por alemán
--
-- Comandos:
--   :TraduceES [range] texto → traduce al español
--   :TraduceEN [range] texto → traduce al inglés
--   :TraduceDE [range] texto → traduce al alemán
--   :TraduceReplaceES [range] texto → reemplaza por español
--   :TraduceReplaceEN [range] texto → reemplaza por inglés
--   :TraduceReplaceDE [range] texto → reemplaza por alemán

local M = {}

-- Modelo a usar
local model = 'deepseek-v4-flash'

-- ---
-- Helpers
-- ---

-- Obtiene el texto seleccionado en modo visual (método fiable)
local function get_visual_selection()
  local old_reg = vim.fn.getreg('z')
  local old_regtype = vim.fn.getregtype('z')
  vim.cmd('silent! noautocmd normal! "zy')
  local text = vim.fn.getreg('z')
  if text == '' then
    vim.cmd('silent! noautocmd normal! "zy')
    text = vim.fn.getreg('z')
  end
  vim.fn.setreg('z', old_reg, old_regtype)
  return text
end

-- Construye el comando llm con system prompt según idioma destino
local function llm_cmd(target_lang)
  local prompts = {
    es = 'Eres un traductor profesional. Traduce todo lo que te diga al español. Responde SOLO con la traducción, sin explicaciones, sin comillas, sin notas.',
    en = 'You are a professional translator. Translate everything you are told to English. Answer ONLY with the translation, no explanations, no quotes, no notes.',
    de = 'Du bist ein professioneller Übersetzer. Übersetze alles, was ich dir sage, ins Deutsche. Antworte NUR mit der Übersetzung, ohne Erklärungen, ohne Anführungszeichen, ohne Notizen.',
  }
  local prompt = prompts[target_lang] or prompts.es
  local escaped_prompt = prompt:gsub("'", "'\\''")
  return "llm -m " .. model .. " -s '" .. escaped_prompt .. "'"
end

-- Llama a llm con el texto y devuelve el resultado (sincrono)
local function translate(text, target_lang)
  if text == nil or text == '' then
    return nil
  end
  local cmd = llm_cmd(target_lang)
  local escaped_text = text:gsub("'", "'\\''")
  local full_cmd = cmd .. " '" .. escaped_text .. "'"
  local result = vim.fn.system(full_cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify('[translate] Error: ' .. result, vim.log.levels.ERROR)
    return nil
  end
  result = result:gsub('^%s*(.-)%s*$', '%1')
  return result
end

-- Guarda el par original→traduccion en ~/vocabulario.md
local function save_to_vocabulary(original, translation)
  local filepath = vim.fn.expand('~/vocabulario.md')
  local today = os.date('%Y-%m-%d')
  local entry = original .. ' → ' .. translation

  -- Si el archivo no existe, crearlo con cabecera
  if vim.fn.filereadable(filepath) == 0 then
    local header = '# Vocabulario\n\n## ' .. today .. '\n\n' .. entry .. '\n'
    vim.fn.writefile(vim.split(header, '\n', { plain = true }), filepath)
    return
  end

  -- Leer contenido existente
  local lines = vim.fn.readfile(filepath)
  local content = table.concat(lines, '\n')

  -- Si ya existe esta entrada, no duplicar
  for _, line in ipairs(lines) do
    if line == entry then
      return
    end
  end

  -- Buscar la ultima linea con fecha (## YYYY-MM-DD)
  local last_date_line = -1
  for i = #lines, 1, -1 do
    if lines[i]:match('^## %d%d%d%d%-%d%d%-%d%d') then
      last_date_line = i
      break
    end
  end

  if last_date_line == -1 then
    -- No hay fecha, añadir nueva seccion
    table.insert(lines, '')
    table.insert(lines, '## ' .. today)
    table.insert(lines, '')
    table.insert(lines, entry)
  else
    local date_on_line = lines[last_date_line]:match('^## (.+)$')
    if date_on_line == today then
      -- Misma fecha: añadir debajo de la fecha
      table.insert(lines, last_date_line + 1, '')
      table.insert(lines, last_date_line + 2, entry)
    else
      -- Fecha distinta: añadir nueva seccion al final
      table.insert(lines, '')
      table.insert(lines, '## ' .. today)
      table.insert(lines, '')
      table.insert(lines, entry)
    end
  end

  vim.fn.writefile(lines, filepath)
end

-- Crea una ventana flotante con la traduccion
-- Se cierra con Esc, q, Enter o moviendo el cursor
local function show_translation(text, translation, target_lang)
  save_to_vocabulary(text, translation)
  local lines = {}
  for line in translation:gmatch('[^\r\n]+') do
    table.insert(lines, line)
  end

  local width = 0
  for _, line in ipairs(lines) do
    if #line > width then width = #line end
  end
  width = math.min(width + 4, 80)
  local height = #lines + 2

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local ui = vim.api.nvim_list_uis()[1]
  local opts = {
    style = 'minimal',
    border = 'rounded',
    relative = 'cursor',
    width = width,
    height = height,
    row = 1,
    col = 0,
  }
  local win = vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_win_set_option(win, 'winhl', 'Normal:NormalFloat')
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)

  -- Teclas para cerrar
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':close<CR>', { nowait = true, silent = true, noremap = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', { nowait = true, silent = true, noremap = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', ':close<CR>', { nowait = true, silent = true, noremap = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Space>', ':close<CR>', { nowait = true, silent = true, noremap = true })
end

-- Reemplaza el texto seleccionado / palabra bajo cursor por la traducción
local function replace_text(text, translation, mode)
  if mode == 'visual' then
    local old_reg = vim.fn.getreg('v')
    vim.cmd('silent! normal! `>')
    vim.cmd('silent! normal! `<' .. '"vd')
    vim.fn.setreg('"', translation)
    vim.cmd('silent! normal! p')
    vim.fn.setreg('v', old_reg)
  else
    local word = vim.fn.expand('<cword>')
    if word and word ~= '' then
      local line = vim.fn.getline('.')
      local col = vim.fn.col('.') - 1
      local line_start = line:sub(1, col)
      local word_start = line_start:match('.*()%w+$') or (col + 1)
      word_start = word_start - 1
      local word_end = (line:sub(col + 1):match('^()%w+') or 1) + col - 1
      local new_line = line:sub(1, word_start) .. translation .. line:sub(word_end + 2)
      vim.fn.setline('.', new_line)
      vim.fn.cursor('.', word_start + #translation + 1)
    end
  end
end

-- Obtiene el texto fuente según el modo actual
local function get_source_text(mode)
  if mode == 'v' or mode == 'V' or mode == '\22' then
    return get_visual_selection()
  else
    return vim.fn.expand('<cword>')
  end
end

-- Función principal
local function translate_action(target, action)
  local mode = vim.fn.mode()
  local text = get_source_text(mode)

  if not text or text == '' then
    vim.notify('[translate] No text to translate', vim.log.levels.WARN)
    return
  end

  vim.notify('[translate] → ' .. target:upper(), vim.log.levels.INFO)

  local result = translate(text, target)
  if not result then return end

  if action == 'replace' then
    local src_mode = (mode == 'v' or mode == 'V' or mode == '\22') and 'visual' or 'normal'
    replace_text(text, result, src_mode)
    vim.notify('[translate] ✓ reemplazado', vim.log.levels.INFO)
  else
    show_translation(text, result, target)
  end
end

-- Comandos
local function create_translate_command(name, target, replace)
  vim.api.nvim_create_user_command(name, function(opts)
    local text
    local range_mode = false

    if opts.range > 0 then
      range_mode = true
      local lines = vim.fn.getline(opts.line1, opts.line2)
      text = table.concat(lines, '\n')
    elseif opts.args and opts.args ~= '' then
      text = opts.args
    else
      text = vim.fn.expand('<cword>')
    end

    if not text or text == '' then
      vim.notify('[translate] No text to translate', vim.log.levels.WARN)
      return
    end

    local result = translate(text, target)
    if not result then return end

    if replace then
      if range_mode then
        local new_lines = {}
        for line in result:gmatch('[^\r\n]+') do
          table.insert(new_lines, line)
        end
        vim.fn.setline(opts.line1, new_lines)
        vim.notify('[translate] ✓ rango reemplazado', vim.log.levels.INFO)
      else
        replace_text(text, result, 'normal')
        vim.notify('[translate] ✓ reemplazado', vim.log.levels.INFO)
      end
    else
      show_translation(text, result, target)
    end
  end, {
    nargs = '*',
    range = '%',
    desc = 'Traduce texto ' .. (replace and 'y reemplaza ' or '') .. 'al ' .. target:upper(),
  })
end

create_translate_command('TraduceES', 'es', false)
create_translate_command('TraduceEN', 'en', false)
create_translate_command('TraduceDE', 'de', false)
create_translate_command('TraduceReplaceES', 'es', true)
create_translate_command('TraduceReplaceEN', 'en', true)
create_translate_command('TraduceReplaceDE', 'de', true)

-- Keymaps
vim.keymap.set({ 'n', 'x' }, '<leader>te', function()
  translate_action('es', 'show')
end, { desc = '[ES] Traducir al español' })

vim.keymap.set({ 'n', 'x' }, '<leader>ti', function()
  translate_action('en', 'show')
end, { desc = '[EN] Traducir al inglés' })

vim.keymap.set({ 'n', 'x' }, '<leader>td', function()
  translate_action('de', 'show')
end, { desc = '[DE] Traducir al alemán' })

vim.keymap.set({ 'n', 'x' }, '<leader>tE', function()
  translate_action('es', 'replace')
end, { desc = '[ES] Reemplazar por español' })

vim.keymap.set({ 'n', 'x' }, '<leader>tI', function()
  translate_action('en', 'replace')
end, { desc = '[EN] Reemplazar por inglés' })

vim.keymap.set({ 'n', 'x' }, '<leader>tD', function()
  translate_action('de', 'replace')
end, { desc = '[DE] Reemplazar por alemán' })

return M
