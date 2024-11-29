-- TODO:
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

    -- Registra atalhos
    local wk = require("which-key")
    wk.add({
      { "<leader>l", group = "Vimtex" },
      { "<leader>lv", desc = "view" },
      { "<leader>ll", desc = "compile" },
      { "<leader>lL", desc = "compile selected" },
      { "<leader>li", desc = "info" },
      { "<leader>lI", desc = "info full" },
      { "<leader>lt", desc = "TOC" },
      { "<leader>lT", desc = "toggle TOC" },
      { "<leader>lq", desc = "log" },
      { "<leader>lv", desc = "view" },
      { "<leader>lr", desc = "reverse search" },
      { "<leader>lk", desc = "stop" },
      { "<leader>lK", desc = "stop all" },
      { "<leader>le", desc = "errors" },
      { "<leader>lo", desc = "compille output" },
      { "<leader>lg", desc = "status" },
      { "<leader>lG", desc = "full status" },
      { "<leader>lc", desc = "clean" },
      { "<leader>lC", desc = "full clean" },
      { "<leader>lx", desc = "reload" },
      { "<leader>lX", desc = "reload state" },
      { "<leader>lm", desc = "input maps list" },
      { "<leader>ls", desc = "toggle main" },
      { "<leader>la", desc = "context menu" },
      { "<leader>la", desc = "context menu" },
    })
  end
}
