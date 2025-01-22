-- DOCS:
-- Friendly snippets:
--  - Repo: 'rafamadriz/friendly-snippets'
--  - Package: https://github.com/rafamadriz/friendly-snippets/blob/main/package.json
--  - Snippets: https://github.com/rafamadriz/friendly-snippets/tree/main/snippets

return {
  'L3MON4D3/LuaSnip',
  name = "luasnip",
  build = 'make install_jsregexp',
  opts = {
    enable_autosnippets=true,
    store_selection_keys = "<Tab>",
  },
  -- Carrega snippets
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/vscode-snippets" } })
  end
}
