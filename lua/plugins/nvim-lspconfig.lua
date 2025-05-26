return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'mason-org/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end
        end,
      })

      local function get_python_venv_path(workspace)
        if vim.env.VIRTUAL_ENV then
          return vim.env.VIRTUAL_ENV .. '/bin/python'
        end

        if not workspace then
          return nil
        end

        -- Find and use virtualenv in workspace directory.
        for _, pattern in ipairs { '*', '.*' } do
          local match = vim.fn.glob(workspace .. '/' .. pattern .. '/pyvenv.cfg')
          if match ~= '' then
            return vim.fs.dirname(match) .. '/bin/python'
          end
        end

        return nil
      end

      local servers = {
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              checkOnSave = true,
              check = {
                command = 'clippy',
              },
              cargo = {
                allFeatures = true,
              },
            },
          },
        },
        taplo = {},
        lua_ls = {},
        basedpyright = {
          before_init = function(_, config)
            local venv_path = get_python_venv_path(config.root_dir)
            if venv_path then
              config.settings.python.pythonPath = venv_path
            end
          end,
          settings = {
            python = {},
            basedpyright = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                typeCheckingMode = 'basic',
                autoImportCompletion = true,
              },
            },
          },
        },
        ruff = {},
        vue_ls = {
          filetypes = { 'javascript', 'typescript', 'vue' },
          init_options = {
            vue = { hybridMode = false },
          },
        },
        eslint = { filetypes = { 'javascript', 'typescript', 'vue' } },
        clangd = {},
        bashls = {},
      }

      vim.api.nvim_create_augroup('AutoFormat', {})

      vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = '*.js,*.ts,*.vue',
        group = 'AutoFormat',
        command = 'silent! EslintFixAll',
      })

      local ensure_installed_formatters = {
        'stylua',
        'shfmt',
        'prettierd',
      }

      require('mason-tool-installer').setup {
        ensure_installed = ensure_installed_formatters,
      }

      local ensure_installed_lsps = vim.tbl_keys(servers or {})

      require('mason-lspconfig').setup {
        ensure_installed = ensure_installed_lsps,
        automatic_enable = false,
      }

      for name, server in pairs(servers) do
        vim.lsp.config(name, server)
        vim.lsp.enable(name, server.autostart == nil or server.autostart)
      end
    end,
  },
}
