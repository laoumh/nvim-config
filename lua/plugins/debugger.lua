-- Debugger e extensões
--
-- NOTE: eventualmente pode ser interessante algo como
-- https://github.com/ldelossa/nvim-dap-projects/
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap-python",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")

    -- Configura aparênica
    vim.fn.sign_define('DapBreakpoint', {text='', texthl='', linehl='', numhl=''})
    vim.fn.sign_define('DapStopped', {text='', texthl='', linehl='Cursor', numhl=''})

    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
    -- vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

    -- Eval var under cursor
    vim.keymap.set("n", "<space>?", function()
      require("dapui").eval(nil, { enter = true })
    end)

    vim.keymap.set("n", "<F1>", dap.continue)
    vim.keymap.set("n", "<F2>", dap.step_into)
    vim.keymap.set("n", "<F3>", dap.step_over)
    vim.keymap.set("n", "<F4>", dap.step_out)
    vim.keymap.set("n", "<F5>", dap.step_back)
    vim.keymap.set("n", "<F13>", dap.restart)

    -- Configura nvim-dap-python
    require("dap-python").setup()
    -- table.insert(dap.configurations.python[1], {
    --   justMyCode = false,
    -- })
    dap.configurations.python[1]["justMyCode"] = false

    -- Configura nvim-dap-ui
    local dapui = require("dapui")
    dapui.setup({
      layouts = {{
          elements = { {
              id = "scopes",
              size = 0.25
            }, {
              id = "breakpoints",
              size = 0.25
            }, {
              id = "stacks",
              size = 0.25
            }, {
              id = "watches",
              size = 0.25
            } },
          position = "left",
          size = 40
        },
        {
          elements = { {
              id = "repl",
              size = 0.5
            }, {
              id = "console",
              size = 0.5
            } },
          position = "bottom",
          size = 10
        },
      },
    })
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end
}
