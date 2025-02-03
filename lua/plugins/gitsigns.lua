-- Adds git related signs to the gutter, as well as utilities for managing changes
  -- See `:help gitsigns` to understand what the configuration keys do
return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      -- signs = {
      --   add = { text = '+' },
      --   change = { text = '~' },
      --   delete = { text = '_' },
      --   topdelete = { text = '‾' },
      --   changedelete = { text = '~' },
      -- },
      signs_staged = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signs_staged_enable = true,
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        -- Configura cores
        local add_color = 'NvimLightGreen'
        local change_color = 'NvimLightYellow'
        vim.cmd.highlight('GitSignsAdd guifg=' .. add_color)
        vim.cmd.highlight('clear GitSignsStagedAdd')
        vim.cmd.highlight('link GitSignsStagedAdd GitSignsAdd')
        vim.cmd.highlight('GitSignsChange guifg=' .. change_color)
        vim.cmd.highlight('clear GitSignsStagedChange')
        vim.cmd.highlight('link GitSignsStagedChange GitSignsChange')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous [c]hange' })

        -- Actions
        -- visual mode
        map('v', '<leader>gs', function()
            gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = 'stage git hunk' })
        map('v', '<leader>gr', function()
            gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
        map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
        map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
        map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
        map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
        map('n', '<leader>gb', gitsigns.blame_line, { desc = 'git [b]lame line' })
        map('n', '<leader>gd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
        map('n', '<leader>gD', function()
          gitsigns.diffthis '@'
        end, { desc = 'git [D]iff against last commit' })
        -- Toggles
        map('n', '<leader>gtb', gitsigns.toggle_current_line_blame, { desc = '[g]it [t]oggle git show [b]lame line' })
        map('n', '<leader>gtd', gitsigns.toggle_deleted, { desc = '[g]it [t]oggle git show [d]eleted' })
      end,
    },
  },
}
