--[[
DOCS:
É possível definir linters em outros plugins, como `after/ftplugin`.
Por exemplo, em `ftplugin/markdown.lua` poderíamos ter
  local lint = require('lint')
  lint.linters_by_ft['markdown'] = { 'markdownlint' }

--]]
return {
  { 'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require('lint')
      -- NOTE:
      -- If no linters defined here, set it to emtpy:
      -- lint.linters_by_ft = {}
      lint.linters_by_ft = {
        bash = { 'shellcheck' },
        sh = { 'shellcheck' },
        -- dockerfile = { "hadolint" },
        -- yaml = { "yamllint" },
      }

      -- Set `lint_enabled` to true or false to enable or disable
      -- the linter by default
      local lint_enabled = true
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      local lint_autocmd = function()
        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
          group = lint_augroup,
          callback = function()
            lint.try_lint()
          end,
        })
        print("Linter enabled")
      end
      if lint_enabled then
        lint_autocmd()
      end

      local toggle_linter = function ()
        if lint_enabled then
          -- If lint is enable, toggle disables it
          -- Clear autocommands to stop the linter
          vim.api.nvim_clear_autocmds({ group = lint_augroup })
          -- Clear diagnostics to remove virtual text and signs
          vim.diagnostic.reset(nil, vim.api.nvim_get_current_buf())
          lint_enabled = false
          print("Linter disabled")
        else
          -- If lint is disabled, toggle enables it
          lint.try_lint()
          lint_enabled = true
          lint_autocmd()
        end
      end

      vim.keymap.set('n', '<leader>L', toggle_linter, { noremap = true, desc = "Toggle Linter" })
    end,
  },
}
