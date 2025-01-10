return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      keymaps = {
        ['<C-l>'] = false,
        ['<C-h>'] = false,
        ['_'] = false,
      },
      view_options = {
        is_always_hidden = function(name, _)
          if vim.startswith(name, '__') and not vim.startswith(name, '__init__.py') then
            return true
          end
          if name == '.git' then
            return true
          end
          if vim.startswith(name, '.') and vim.endswith(name, 'cache') then
            return true
          end
          if vim.endswith(name, '.egg-info') then
            return true
          end

          return false
        end,
        show_hidden = true,
      },
    }
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end,
}
