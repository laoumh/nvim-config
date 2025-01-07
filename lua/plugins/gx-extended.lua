return {
  'rmagatti/gx-extended.nvim',
  keys = { 'gx' },
  opts = {
    open_fn = vim.ui.open,
    extensions = {
      { -- match github repos in lazy.nvim plugin specs
        patterns = { '*/plugins/**.lua' },
        name = "neovim plugins",
        match_to_url = function(line_string)
          -- DOCS:
          -- Ver `:help lua-patterns`
          local line = string.match(line_string, '["\'].*/.*["\']')
          local repo = vim.split(line, ':')[1]:gsub('["\']', '')
          local url = 'https://github.com/' .. repo
          return line and repo and url or nil
        end,
      },
      { -- match github repos in lazy.nvim plugin specs
        patterns = { '**/Pipfile', '**/requirements.txt' },
        name = "pip packages",
        match_to_url = function(line_string)
          -- DOCS:
          -- pip package naming convention: https://peps.python.org/pep-0508/#names
          local pkg = string.match(line_string, '[%w][%w._-]*[%w]')
          local url = 'https://pypi.org/project/' .. pkg
          return pkg and url or nil
        end,
      },
    },
  }
}
