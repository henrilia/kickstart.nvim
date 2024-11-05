require('lazy').setup({

  'tpope/vim-sleuth',

  require 'plugins/comment',

  require 'plugins/dashboard-nvim',

  require 'plugins/bigfile',

  require 'plugins/trouble',

  require 'plugins/nvim-lspimport',

  require 'plugins/supermaven',

  require 'plugins/gitsigns',

  require 'plugins/lazygit',

  require 'plugins/which-key',

  require 'plugins/telescope',

  require 'plugins/nvim-lspconfig',

  require 'plugins/multicursor',

  require 'plugins/conform',

  require 'plugins/nvim-cmp',

  require 'plugins/kanagawa',

  require 'plugins/vim-tmux-navigator',

  require 'plugins/vim-test',

  require 'plugins/oil',

  require 'plugins/todo-comments',

  require 'plugins/mini',

  require 'plugins/nvim-treesitter',

  require 'plugins/lualine',

  require 'plugins/nvim-treesitter-context',
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
