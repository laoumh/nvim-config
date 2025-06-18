--[[ CONFIG ]]
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2

-- Define matchit patterns for Django template tags
vim.b.match_words = table.concat({
  '{% autoescape\\s\\+[onf]*\\>:\\<endautoescape\\s*%}',
  '{% block\\>:\\<endblock\\s*%}',
  '{% blocktranslate\\>:\\<endblocktranslate\\s*%}',
  '{% cache\\s\\+:\\<endcache\\s*%}',
  '{% comment\\>:\\<endcomment\\s*%}',
  '{% for\\>:\\<endfor\\s*%}',
  '{% if\\>:\\<elif\\s*%}:\\<else\\s*%}:\\<endif\\s*%}',
  '{% if\\>:\\<endif\\s*%}',
  '{% spaceless\\>:\\<endspaceless\\s*%}',
  '{% with\\>:\\<endwith\\s*%}',
}, ',')

-- Duplica '%%'
local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')
local cond = require('nvim-autopairs.conds')
npairs.add_rules({
  Rule("%","%","htmldjango")
    :with_pair(cond.before_text("{")),
  Rule(" "," ","htmldjango")
    -- :with_pair(cond.before_text("%"))
    -- :with_pair(cond.before_text("{")),
    :with_pair(cond.before_regex("{%%-")),
})

