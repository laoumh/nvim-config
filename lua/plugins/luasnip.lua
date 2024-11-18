return {
  'L3MON4D3/LuaSnip',
  name = "luasnip",
  build = 'make install_jsregexp',
  dependencies = {
    -- `friendly-snippets` contains a variety of premade snippets.
    --    See the README about individual language/framework/plugin snippets:
    --    https://github.com/rafamadriz/friendly-snippets
    -- {
    --   'rafamadriz/friendly-snippets',
    --   config = function()
    --     require('luasnip.loaders.from_vscode').lazy_load()
    --   end,
    -- },
    --
  },
  opts = {
    enable_autosnippets=true,
    store_selection_keys = "<Tab>",
  },
  -- Carrega snippets
  init = function()
    local lua_loader = require("luasnip.loaders.from_lua")
    lua_loader.load({paths = "~/.config/nvim/LuaSnip/"})
  end
}
