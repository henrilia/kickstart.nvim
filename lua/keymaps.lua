vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set('n', '<S-j>', '6j')
vim.keymap.set('n', '<S-k>', '6k')

vim.keymap.set('n', '<A-k>', 'yyddkP')
vim.keymap.set('n', '<A-j>', 'yyddp')

vim.keymap.set('n', '<leader>w', ':write<CR>')

vim.keymap.set('n', '<leader>gs', ':/<script<CR>')

vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', { desc = 'Move focus to the window below' })
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', { desc = 'Move focus to the window above' })
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', { desc = 'Move focus to the right window' })

vim.keymap.set('n', 'H', '<cmd>bprev<CR>', { desc = 'Move to the previous buffer' })
vim.keymap.set('n', 'L', '<cmd>bnext<CR>', { desc = 'Move to the next buffer' })

vim.keymap.set('n', '<leader>p', '<cmd>cprev<CR>', { desc = 'Move to previous entry in the quickfix list' })
vim.keymap.set('n', '<leader>n', '<cmd>cnext<CR>', { desc = 'Move to next entry in the quickfix list' })

vim.keymap.set('n', '<leader>cc', '<cmd>cclose<CR>', { desc = 'Close the quickfix list' })
vim.keymap.set('n', '<leader>co', '<cmd>copen<CR>', { desc = 'Open the quickfix list' })

vim.keymap.set('n', '<leader>bd', function()
  vim.cmd 'bd'
end, { desc = 'Close current buffer' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_user_command('Q', function()
  vim.cmd 'q'
end, {})
