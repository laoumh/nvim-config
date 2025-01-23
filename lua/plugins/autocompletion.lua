-- Autocompletion plugins
-- Autoformat: se algum dia precisar, ver 'stevearc/conform.nvim'
return {
  -- Detect tabstop and shiftwidth automatically
  { 'tpope/vim-sleuth' },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  -- nvim-cmp sources
  { 'saadparwaiz1/cmp_luasnip', dependencies = { 'hrsh7th/nvim-cmp' } },
  { 'hrsh7th/cmp-nvim-lsp', dependencies = { 'hrsh7th/nvim-cmp' } },
  { 'hrsh7th/cmp-path', dependencies = { 'hrsh7th/nvim-cmp' } },
  { 'hrsh7th/cmp-buffer', dependencies = { 'hrsh7th/nvim-cmp' } },
  {
    'hrsh7th/cmp-cmdline',
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function ()
      -- `/` Autocompleta busca com termos do buffer
      local cmp = require 'cmp'
      cmp.setup.cmdline('/', {
        native_menu = false,
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
      -- `:` Autocompleta comandos
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' },
            },
            keyword_length = 2,
          }
        })
      })
    end
  },
  -- nvim-cmp main plugin
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      "luasnip",
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      -- DOCS: `:help completeopt`
      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect', 'preview' }

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        -- DOCS:
        -- `:help ins-completion`
        -- `:help key-notation` para como especificar teclas
        mapping = cmp.mapping.preset.insert {
          -- Select next or previous suggestion
          ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ['<PageDown>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select , count = 5}),
          ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ['<PageUp>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select , count = 5}),
          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-u>'] = cmp.mapping.scroll_docs(4),
          -- Accept selected suggestion
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          -- Toggle completion menu
          ['<C-Space>'] = cmp.mapping(function()
            if cmp.visible() then
              cmp.abort()
            else
              cmp.complete()
            end
          end, {'i', 's'}),

          -- [[ Snippet navigation ]]
          -- DOCS:
          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
          --
          -- jump right
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          -- jump left
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'vimtex' },
        },
      }
    end,
  },
}
