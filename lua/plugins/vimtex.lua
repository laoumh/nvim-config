-- TODO:
--  - Configurar latexmkrc
--  - Considerar o LSP (Gramática) https://valentjn.github.io/ltex/index.html
return {
  "lervag/vimtex",
  lazy = false,
  ft = "tex",
  dependencies = {
    -- Configuração: https://github.com/micangl/cmp-vimtex/blob/master/doc/TUTORIAL.md
    'micangl/cmp-vimtex',
  },
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- Inverse search:
    --   - No editor: <f4> (toggle_synctec)
    --   - clique com mouse direito
    --   - Obs: necessário `lazy = false` para busca inversa funcionar
    -- Docs: https://sioyek-documentation.readthedocs.io/
    vim.g.vimtex_view_method = "sioyek"
  end
}
