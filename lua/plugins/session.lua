-- Session managers

local session_breakpoints = require('utils.session-breakpoints')

return {
  -- NOTE:
  -- Comando `:SessionSearch` abre menu com sessões disponíveis
  -- Ver o repositório para outras funções e configurações
  'rmagatti/auto-session',
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { '~/' },
    post_save_cmds = { session_breakpoints.save_session_breakpoints },
    post_restore_cmds = { session_breakpoints.restore_session_breakpoints },
    pre_delete_cmds = { session_breakpoints.delete_session_breakpoints },
  },
  init = function ()
    --DOCS:
    -- `:help sessionoptions`
    vim.o.sessionoptions="curdir,folds,help,tabpages,winsize,winpos,localoptions"
  end
}
