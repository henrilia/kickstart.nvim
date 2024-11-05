return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    require('kanagawa').setup {
      commentStyle = { italic = false },
      keywordStyle = { italic = false },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = 'none',
            },
          },
        },
      },
    }
    vim.cmd.colorscheme 'kanagawa'
  end,
}
