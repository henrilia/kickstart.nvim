return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      keymaps = {
        ['<C-l>'] = false,
        ['<C-h>'] = false,
      },
      view_options = {
        show_hidden = true,
      },
    }
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end,
}
