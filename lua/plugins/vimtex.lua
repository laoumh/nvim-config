-- TODO:
--  - Configurar latexmkrc
--  - Considerar o LSP (Gramática) https://valentjn.github.io/ltex/index.html
return {
  "lervag/vimtex",
  lazy = true,
  ft = "tex",
  dependencies = {
    -- Configuração: https://github.com/micangl/cmp-vimtex/blob/master/doc/TUTORIAL.md
    'micangl/cmp-vimtex',
  },
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "zathura"
  end
}
