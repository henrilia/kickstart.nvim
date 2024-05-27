return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    { 'folke/neodev.nvim', opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

        -- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<F2>', vim.lsp.buf.rename, '[R]e[n]ame')

        map('<leader>rl', ':LspRestart<CR>', '[R]estart [L]SP')

        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

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
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local util = require 'lspconfig/util'
    local servers = {
      rust_analyzer = {
        filetypes = { 'rust' },
        root_dir = util.root_pattern 'Cargo.toml',
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              command = 'clippy',
            },
            cargo = {
              allFeatures = true,
            },
          },
        },
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
      ruff_lsp = {
        root_dir = util.root_pattern 'requirements.txt',
      },
      ['css-lsp'] = {
        filetypes = { 'css', 'vue' },
      },
      volar = {
        filetypes = { 'typescript', 'javascript', 'vue' },
        root_dir = util.root_pattern 'src/App.vue',
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
      tsserver = {
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

          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
