return {
  -- Logs highlight
  { 'fei6409/log-highlight.nvim', opts = {}},
  -- Window separator
  {
    "nvim-zh/colorful-winsep.nvim",
    -- config = true,
    opts = {
      hi = {
        fg = "#4D4941",
        -- bg = "#0000FF",
      },
    },
    event = { "WinLeave" },
  },
}
