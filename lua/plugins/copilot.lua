return {
  'github/copilot.vim',
  config = function()
    vim.keymap.set('i', '<C-K>', '<Plug>(copilot-accept-word)')
    vim.keymap.set('i', '<C-O>', '<Plug>(copilot-accept-line)')
  end,
}
