return {
  'ghillb/cybu.nvim',
  requires = { 'nvim-tree/nvim-web-devicons', 'nvim-lua/plenary.nvim' },
  keys = {
    {
      mode = { 'n' },
      'H',
      '<cmd>CybuPrev<CR>',
      desc = 'Go to previous buffer',
    },
    {
      mode = { 'n' },
      'L',
      '<cmd>CybuNext<CR>',
      desc = 'Go to next buffer',
    },
  },
  config = function()
    local cybu = require 'cybu'
    cybu.setup {
      position = {
        max_win_width = 0.8,
      },
      style = {
        path = 'relative',
      },
      display_time = 550,
    }
  end,
}
