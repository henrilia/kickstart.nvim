return {
  'olimorris/onedarkpro.nvim',
  priority = 1000,
  config = function()
    require('onedarkpro').setup {
      colors = {
        selection = '#404040',
      },
    }
    vim.cmd.colorscheme 'onedark_dark'
  end,
}
