require('lazy').setup({

  'tpope/vim-sleuth',

  { 'numToStr/Comment.nvim', opts = {} },

  require 'kickstart/plugins/trouble',

  require 'kickstart/plugins/nvim-lspimport',

  -- require 'kickstart/plugins/codeium',

  require 'kickstart/plugins/gitsigns',

  require 'kickstart/plugins/lazygit',

  require 'kickstart/plugins/which-key',

  require 'kickstart/plugins/telescope',

  require 'kickstart/plugins/nvim-lspconfig',

  require 'kickstart/plugins/copilot',

  require 'kickstart/plugins/vim-visual-multi',

  require 'kickstart/plugins/conform',

  require 'kickstart/plugins/nvim-cmp',

  require 'kickstart/plugins/onedarkpro',

  require 'kickstart/plugins/vim-tmux-navigator',

  require 'kickstart/plugins/vim-test',

  require 'kickstart/plugins/oil',

  require 'kickstart/plugins/todo-comments',

  require 'kickstart/plugins/mini',

  require 'kickstart/plugins/nvim-treesitter',

  require 'kickstart/plugins/lualine',
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
