-- Autocompletion plugins
-- Autoformat: se algum dia precisar, ver 'stevearc/conform.nvim'

-- DOCS:
-- cmp.mapping(<ação>, {<modos>})
--
-- [[ Completion menu navigation ]]
local function get_menu_mapping()
  local cmp = require('cmp')
  local mapping = {
    -- Select next or previous suggestion
    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i', 'c'}),
    ['<PageDown>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select , count = 5}), {'i', 'c'}),
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i', 'c'}),
    ['<PageUp>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select , count = 5}), {'i', 'c'}),
    -- Scroll the documentation window [b]ack / [f]orward
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
    -- Accept selected suggestion
    ['<CR>'] = cmp.mapping(cmp.mapping.confirm({ select = false }), {'i', 'c'}),
    ['<C-y>'] = cmp.mapping(cmp.mapping.confirm({ select = true }), {'i', 'c'}),
    -- Toggle completion menu
    ['<C-Space>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.abort()
      else
        cmp.complete()
      end
    end, {'i', 'c', 's'}),
  }

  return mapping
end

-- [[ Snippet navigation ]]
-- DOCS:
-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
local function get_snippet_mapping()
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  local mapping = {
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
  }

  return mapping
end

return {
  -- Detect tabstop and shiftwidth automatically
  {
    'tpope/vim-sleuth',
    enabled = false,
  },
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
        mapping = cmp.mapping.preset.cmdline(get_menu_mapping()),
        sources = {
          { name = 'buffer' }
        }
      })
      -- `:` Autocompleta comandos
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(get_menu_mapping()),
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
  {
    -- Palavras do dicionário
    'uga-rosa/cmp-dictionary',
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function ()
      local cmp = require 'cmp'
      cmp.setup.filetype('markdown', {
        performance = {
          max_view_entries = 7,
        },
        sources = {
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
          {
            name = "dictionary",
            keyword_length = 3,
          },
        }
      })

      require("cmp_dictionary").setup({
        paths = {
          "/usr/share/dict/brazilian",
          "/usr/share/dict/american-english",
        },
        exact_length = 3,
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
        mapping = cmp.mapping.preset.insert(vim.tbl_extend('force', get_menu_mapping(), get_snippet_mapping())) ,
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
