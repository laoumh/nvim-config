-- LSP Plugins
--[[
DOCS:
 - Para adicionar um LSP, criar entrada em {nvim-config}/after/ftplugin/<lang>.lua
 - Ver `:help lsp-vs-treesitter`
 - Tabela de LSPs por linguagem:
    https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers

--]]
return {
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
    init = function ()
      local wk = require('which-key')
      wk.add({
        {"<leader>co", '<Cmd>AerialToggle left<cr>', desc = "[C]ode [O]utline", icon = {icon = "", color = "blue"} },
      })
    end
  },
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    dependencies = {
      { 'Bilal2453/luvit-meta', lazy = true },
    },
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        { plugins = { "nvim-dap-ui" }, types = true },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {
          progress = {
            ignore_done_already = true,
            display = {
              -- tempo de persistência das mensagens
              done_ttl = 5,
            },
          },
          notification = {
            override_vim_notify = true,
          },
        },
      },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local tsbuiltin = require('telescope.builtin')
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local supports_method = function (method)
            return client and client.supports_method(method)
          end
          -- Ver `:help lsp-method`
          local lsp_methods = vim.lsp.protocol.Methods
          local fname = vim.api.nvim_buf_get_name(event.buf)

          -- [[ CONFIGURA ATALHOS ]]
          local wk = require("which-key")
          wk.add({
            { "<leader>l", group = "[L]SP", mode = "n", icon = {cat = 'file', name = fname}  },
            {
              mode = "n",

              -- Rename the variable under your cursor.
              { '<leader>lr', vim.lsp.buf.rename, desc = '[R]ename',
                cond = supports_method(lsp_methods.textDocument_rename)
              },

              -- Execute a code action
              { '<leader>lc', vim.lsp.buf.code_action, desc = '[C]ode Action', icon = "󰈸", mode = { 'n', 'x' },
                cond = supports_method(lsp_methods.textDocument_codeAction)
              },

              -- Toggle inlay hints. Ex: mostra args de função
              { '<leader>lh', function()
                  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                end,
                desc = 'Toggle Inlay [H]ints',
                cond = supports_method(lsp_methods.textDocument_inlayHint),
              },

              -- GOTO
              { "<leader>lg", group = "[G]oto", icon = ""},
              { '<leader>lgd', tsbuiltin.lsp_definitions, desc = '[D]efinition',
                cond = supports_method(lsp_methods.textDocument_definition),
              },
              --  Declaration: in C this would take you to the header, for example
              { '<leader>lgD', vim.lsp.buf.declaration, desc = '[D]eclaration',
                cond = supports_method(lsp_methods.textDocument_declaration),
              },
              --  Useful when your language has ways of declaring types without an actual implementation.
              { '<leader>lgi', tsbuiltin.lsp_implementations, desc = '[I]mplementation',
                cond = supports_method(lsp_methods.textDocument_implementation),
              },
              -- Jump to the TYPE of the word under your cursor.
              { '<leader>lgt', tsbuiltin.lsp_type_definitions, desc = '[T]ype Definition',
                cond = supports_method(lsp_methods.textDocument_typeDefinition),
              },

              -- FIND
              --  Symbols are things like variables, functions, types, etc.
              { "<leader>lf", group = "[F]ind", icon = "󰮗"},
              { '<leader>lfr', tsbuiltin.lsp_references, desc = '[R]eferences',
                cond = supports_method(lsp_methods.textDocument_typeDefinition),
              },
              -- Search this document
              { '<leader>lfd', tsbuiltin.lsp_document_symbols, desc = '[D]ocument Symbols',
                cond = supports_method(lsp_methods.textDocument_documentSymbol),
              },
              -- Search whole workspace
              { '<leader>lfw', tsbuiltin.lsp_dynamic_workspace_symbols, desc = '[W]orkspace Symbols',
                cond = supports_method(lsp_methods.workspace_symbol),
              },
            },
          })

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          if supports_method(lsp_methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            -- When you move your cursor, the highlights will be cleared
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
    end,
  },
}
