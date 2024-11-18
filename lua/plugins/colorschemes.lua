-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
return {
  -- Há quatro estilos disponíveis:
  --   'tokyonight-night', 'tokyonight-storm', 'tokyonight-moon' e 'tokyonight-day'.
  {
    'folke/tokyonight.nvim',
    -- lazy = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'tanvirtin/monokai.nvim',
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
