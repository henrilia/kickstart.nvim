return {
  'stevearc/conform.nvim',
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_format', 'ruff_fix' },
      javascript = { 'prettierd' },
      typescript = { 'prettierd' },
      json = { 'prettierd' },
      vue = { 'prettierd' },
      rust = { 'rustfmt' },
      toml = { 'taplo' },
      cpp = { 'clang-format' },
      html = { 'prettierd' },
      bash = { 'shfmt' },
      sh = { 'shfmt' },
    },
  },
}
