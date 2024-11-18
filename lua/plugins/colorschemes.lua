-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
return {
  -- Há quatro estilos disponíveis:
  --   'tokyonight-night', 'tokyonight-storm', 'tokyonight-moon' e 'tokyonight-day'.
  {
    'folke/tokyonight.nvim',
    lazy = true,
    init = function()
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'tanvirtin/monokai.nvim',
    lazy = true,
    opts = {
      palette = nil,
      -- palette = 'pro',
      -- palette = 'soda',
      -- palette = 'ristretto',
      -- Falso se não quiser itálicos
      italics = true,
    },
  },
}
