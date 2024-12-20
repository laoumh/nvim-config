-- Session managers
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
  }
}
