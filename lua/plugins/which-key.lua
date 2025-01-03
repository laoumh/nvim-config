  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end
return  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      preset = 'modern',
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
      },
      expand = 0,

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>g', group = '[g]it Hunk', mode = { 'n', 'v' } },

        -- Configura modo diff
        { 'dm', group = '[d]iff [m]ode', icon = "", mode = { 'n' } },
        { 'dmb', '<cmd>diffget<CR>', desc = 'get bloco', mode = { 'n' } },
        { 'dml', '<cmd>.,. diffget<CR>', desc = 'get linha atual', mode = { 'n' } },
        { 'dmpb', '<cmd>diffput<CR>', desc = 'put bloco', mode = { 'n' } },
        { 'dmpl', '<cmd>.,. diffput<CR>', desc = 'put linha atual', mode = { 'n' } },
      },
    },
  }
