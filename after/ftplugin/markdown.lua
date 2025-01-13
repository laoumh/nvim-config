--[[LINT
DOCS:
Instalar `markdownlint`
 - `:MasonInstal markdownlint`

]]
local lint = require('lint')
lint.linters_by_ft['markdown'] = { 'markdownlint' }
