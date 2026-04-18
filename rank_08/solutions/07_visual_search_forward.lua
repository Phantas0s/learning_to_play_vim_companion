local function visual_search_forward()
  -- Save the current values of the registers
  local cunnamed = vim.fn.getreg('"')
  local cyank = vim.fn.getreg('0')

  -- Yank the selection
  vim.cmd('normal! y')

  -- Escape any backslash to avoid interpreting it as an escape sequence
  local yank = string.gsub(vim.fn.getreg('0'), '\\', '\\\\')

  -- Search for the yanked text
  -- \V makes the pattern 'very nomagic' (always literal)
  vim.fn.search('\\V' .. yank)

  -- Set the yanked selection as value for the search register
  -- Enables n and N in normal mode
  vim.fn.setreg('/', yank)

  -- Restore the previous values of the registers
  vim.fn.setreg('"', cunnamed)
  vim.fn.setreg('0', cyank)
end

vim.keymap.set('x', '*', visual_search_forward, { noremap = true })
