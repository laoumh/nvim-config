return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        bash = { 'shellcheck' },
        markdown = { 'markdownlint' },
        sh = { 'shellcheck' },
        python = {
          -- "ruff",
          -- "pycodestyle",
          -- "pylint",
        }
        -- dockerfile = { "hadolint" },
        -- yaml = { "yamllint" },
      }

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      -- lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

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
