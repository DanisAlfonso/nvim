-- speak.lua
-- Pronuncia palabras con "say" en macOS
-- <leader>ap en modo normal → palabra bajo el cursor
-- <leader>ap en modo visual → selección visual
--
-- Comandos:
--   :SpeakWord [text]    → pronuncia texto, o palabra bajo cursor
--   :SpeakVoice [name]   → cambia la voz (por defecto 'Petra' para alemán)
--   :SpeakVoiceList      → lista voces disponibles

local M = {}

M.voice = 'Petra'

-- Obtiene la selección visual actual mediante yank al registro temporal.
-- Es el método más fiable: funciona en v, V, Ctrl-V, en primera selección
-- y en selecciones sucesivas.
local function get_visual_selection()
  local old_reg = vim.fn.getreg('z')
  local old_regtype = vim.fn.getregtype('z')
  vim.cmd('silent! noautocmd normal! "zy')
  local text = vim.fn.getreg('z')

  -- Si el yank no devolvió nada, reintentar
  if text == '' then
    vim.cmd('silent! noautocmd normal! "zy')
    text = vim.fn.getreg('z')
  end

  vim.fn.setreg('z', old_reg, old_regtype)
  return text
end

-- Pronuncia texto usando jobstart (no bloquea Neovim)
function M.speak(text)
  if text == nil or text == '' then
    vim.notify('[speak] No text to speak', vim.log.levels.WARN)
    return
  end

  local args
  if M.voice then
    args = { 'say', '-v', M.voice, text }
  else
    args = { 'say', text }
  end

  local job_id = vim.fn.jobstart(args, { detach = true })
  if job_id == -1 then
    vim.notify('[speak] Error: say command not found', vim.log.levels.ERROR)
  end
end

-- Pronuncia la palabra bajo el cursor (modo normal)
function M.speak_word()
  local word = vim.fn.expand('<cword>')
  if word == '' then
    vim.notify('[speak] No word under cursor', vim.log.levels.WARN)
    return
  end
  M.speak(word)
end

-- Pronuncia el texto seleccionado en modo visual
function M.speak_selection()
  local mode = vim.fn.mode()
  if mode ~= 'v' and mode ~= 'V' and mode ~= '\22' then
    vim.notify('[speak] Not in visual mode (mode=' .. mode .. ')', vim.log.levels.WARN)
    return
  end

  local text = get_visual_selection()
  if text == '' then
    vim.notify('[speak] No selection', vim.log.levels.WARN)
    return
  end

  M.speak(text)
end

-- Comandos
vim.api.nvim_create_user_command('SpeakWord', function(opts)
  if opts.args and opts.args ~= '' then
    M.speak(opts.args)
  else
    M.speak_word()
  end
end, { nargs = '?', desc = 'Pronuncia una palabra. Sin args usa la del cursor.' })

vim.api.nvim_create_user_command('SpeakVoice', function(opts)
  if opts.args and opts.args ~= '' then
    M.voice = opts.args
    vim.notify('[speak] Voz cambiada a: ' .. M.voice, vim.log.levels.INFO)
  else
    vim.notify('[speak] Voz actual: ' .. (M.voice or 'default del sistema'), vim.log.levels.INFO)
  end
end, { nargs = '?', desc = 'Cambia la voz. Ej: SpeakVoice Petra' })

vim.api.nvim_create_user_command('SpeakVoiceList', function()
  local handle = io.popen('say -v "?" 2>/dev/null | head -60')
  if handle then
    local result = handle:read('*a')
    handle:close()
    vim.notify('[speak] Voces disponibles:\n' .. result, vim.log.levels.INFO)
  end
end, { desc = 'Lista las primeras 60 voces en macOS' })

-- Keymaps
vim.keymap.set('n', '<leader>ap', function()
  M.speak_word()
end, { desc = 'Pronunciar palabra bajo el cursor' })

vim.keymap.set('x', '<leader>ap', function()
  M.speak_selection()
end, { desc = 'Pronunciar selección visual' })

return M
