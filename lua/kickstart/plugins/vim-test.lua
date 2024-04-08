return {
  'vim-test/vim-test',
  dependencies = { 'preservim/vimux' },
  config = function()
    vim.keymap.set('n', '<leader>tt', ':TestNearest<CR>')
    vim.keymap.set('n', '<leader>T', ':TestFile<CR>')
    vim.keymap.set('n', '<leader>ta', ':TestSuite<CR>')
    vim.keymap.set('n', '<leader>tl', ':TestLast<CR>')
    vim.cmd "let test#strategy = 'vimux'"
  end,
}
