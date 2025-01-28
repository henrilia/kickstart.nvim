return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    { 'folke/neodev.nvim', opts = {} },
    { 'saghen/blink.cmp' },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

    local util = require 'lspconfig/util'

    local function get_python_path(workspace)
      -- Use activated virtualenv.
      if vim.env.VIRTUAL_ENV then
        return vim.env.VIRTUAL_ENV .. '/bin/python'
      end

      -- Find and use virtualenv in workspace directory.
      for _, pattern in ipairs { '*', '.*' } do
        local match = vim.fn.glob(workspace .. '/' .. pattern .. '/pyvenv.cfg')
        if match ~= '' then
          return vim.fs.dirname(match) .. '/bin/python'
        end
      end

      -- Fallback to system Python.
      return vim.fn.exepath 'python3' or vim.fn.exepath 'python' or 'python'
    end

    local servers = {
      zls = {
        filetypes = { 'zig' },
        root_dir = util.root_pattern '.git',
      },
      -- bacon = {
      --   filetypes = { 'rust' },
      --   root_dir = util.root_pattern 'Cargo.toml',
      -- },
      -- ['bacon-ls'] = {
      --   filetypes = { 'rust' },
      --   root_dir = util.root_pattern 'Cargo.toml',
      -- },
      rust_analyzer = {
        filetypes = { 'rust' },
        root_dir = util.root_pattern 'Cargo.toml',
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              command = 'clippy',
              -- enable = false,
            },
            -- diagnostics = {
            --   enable = false,
            -- },
            cargo = {
              allFeatures = true,
            },
          },
        },
      },
      taplo = {
        filetypes = { 'toml' },
      },
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
      },
      pyright = {
        before_init = function(_, config)
          config.settings.python.pythonPath = get_python_path(config.root_dir)
        end,
        settings = {
          pyright = { autoImportCompletion = true },
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              typeCheckingMode = 'basic',
            },
          },
        },
      },
      ruff = {},
      ['css-lsp'] = {
        filetypes = { 'css', 'vue' },
      },
      volar = {
        filetypes = { 'typescript', 'javascript', 'vue' },
        root_dir = util.root_pattern 'src_pvt/App.vue',
        init_options = {
          vue = {
            hybridMode = false,
          },
        },
      },
      ['eslint-lsp'] = {
        filetypes = {
          'javascript',
          'typescript',
          'vue',
        },
      },
      prettierd = {
        filetypes = { 'javascript', 'typescript', 'vue' },
      },
      ts_ls = {
        autostart = false,
        init_options = {
          plugins = {
            {
              name = '@vue/typescript-plugin',
              location = '/home/henrik/.local/share/pnpm/global/5/node_modules/@vue/typescript-plugin/',
              languages = { 'javascript', 'typescript', 'vue' },
            },
          },
        },
        filetypes = {
          'javascript',
          'typescript',
          'vue',
        },
        commands = {
          OrganizeImports = {
            function()
              local params = {
                command = '_typescript.organizeImports',
                arguments = { vim.api.nvim_buf_get_name(0) },
                title = '',
              }
              vim.lsp.buf.execute_command(params)
            end,
            description = 'Organize Imports',
          },
        },
      },
      clangd = {},
    }

    vim.api.nvim_create_augroup('AutoFormat', {})

    vim.api.nvim_create_autocmd('BufWritePost', {
      pattern = '*.js,*.ts,*.vue',
      group = 'AutoFormat',
      command = 'silent! EslintFixAll',
    })

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}

          server.capabilities = require('blink.cmp').get_lsp_capabilities(server.capabilities or {})
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

          require('lspconfig')[server_name].setup(server)
        end,
      },
    }

    -- TODO: Find out why this is needed
    require('lspconfig').ruff.setup {}
    -- require('lspconfig').bacon_ls.setup {}
  end,
}
