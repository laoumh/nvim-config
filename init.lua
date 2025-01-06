--[[

DOCS:
Lua:
    - https://learnxinyminutes.com/docs/lua/
    - :help lua-guide

--]]

-- Carrega configurações
require("settings.keymaps")
require("settings.settings")
require("settings.autocommands")

-- Carrega lazy.nvim plugin manager
require("config.lazy")

-- Carrega colorscheme depois do lazy, já que pode depender de plugins
require("settings.colorscheme")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
