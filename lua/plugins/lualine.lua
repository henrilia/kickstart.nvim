return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'f-person/git-blame.nvim' },
  config = function()
    vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
    vim.g.gitblame_message_template = '<author> • <date>' -- Customize git blame message
    vim.g.gitblame_date_format = '%x' -- Customize date format
    vim.g.gitblame_deplay = 0
    local git_blame = require 'gitblame'
    git_blame.setup()

    require('lualine').setup {
      options = { theme = 'ayu_mirage' },
      sections = {
        lualine_c = {
          { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
          { 'filename' },
        },
      },
    }
  end,
}
