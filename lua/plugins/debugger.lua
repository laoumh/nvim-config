-- Debugger e extensões
--
-- NOTE: Linguagens configuradas:
--  - Python
--
-- DOCS:
-- Eventos DAP: https://microsoft.github.io/debug-adapter-protocol/specification.html
--
-- TODO: 
--  - Se necessário configuração por projeto: https://github.com/ldelossa/nvim-dap-projects/
--  - Se necessária instalação automática de DAPs: 'jay-babu/mason-nvim-dap.nvim',
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    ft = {"python"},
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Configura aparência
      vim.fn.sign_define('DapBreakpoint', {text='', texthl='', linehl='', numhl=''})
      vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='', linehl='', numhl=''})
      vim.fn.sign_define('DapStopped', {text='', texthl='', linehl='Cursor', numhl=''})

      -- [[ CONFIGURA ATALHOS ]]
      local wk = require("which-key")
      wk.add({
        {
          mode = "n", icon = {color = "yellow"},
          { "<F1>", dap.continue, desc = "Debug: iniciar/continuar", icon = "" },
          { "<F2>", dap.step_into, desc = "Debug: step", icon = "" },
          { "<F3>", dap.step_over, desc = "Debug: next", icon = "" },
          { "<F4>", dap.step_out, desc = "Debug: step out", icon = "" },
          { "<F5>", dap.step_back, desc = "Debug: step back", icon = "" },
        },
      })
      wk.add({
        { "<leader>d", group = "[D]ebug", icon = { icon = "", color = "yellow" }, mode = "n" },
        {
          mode = "n",
          -- Ações debug
          { "<leader>db", dap.toggle_breakpoint, desc = "Toggle breakpoint" },
          { "<leader>dc", dap.clear_breakpoints, desc = "Clear breakpoint", icon = {icon = "󰇾", color = "red"} },
          { "<leader>dr", dap.run_to_cursor, desc = "Run to cursor", icon = "" },
          { "<leader>du", dap.up, desc = "Up the stacktrace", icon = "" },
          { "<leader>dd", dap.down, desc = "Down the stacktrace", icon = "" },
          { "<leader>df", dap.focus_frame, desc = "Focus frame", icon = "󰋱" },
          {
            '<leader>dB',
            function()
              dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
            end,
            desc = "Conditional breakpoint",
            icon = ""
          },

          -- Interrompe / reinicia debugger
          { "<leader>dr", function ()
              if dap.session() then
                dap.restart()
              else
                dap.run_last()
              end
            end,
            desc = "Restart", icon = {icon = "", color = "yellow"}
          },
          { "<leader>ds", function ()
              dap.disconnect()
              dapui.close()
            end,
            desc = "Stop debugging", icon = {icon = "", color = "red"}
          },

          -- inspeção de variáveis
          { "<leader>di", function()
                dapui.eval(nil, { enter = true })
              end
            , desc = "Inspect element", icon = {icon = "", color = "yellow"}
          },
        },
      })
      -- Exceções
      wk.add({
        { "<leader>dx", group = "E[x]ceptions", icon = { icon = "", color = "yellow" }, mode = "n" },
        {
          mode = "n",
          { "<leader>dxs", function ()
              dap.set_exception_breakpoints()
            end,
            desc = "Habilita breakpoint em exceções",
            icon = { icon = "", color = "green" }
          },
          { "<leader>dxu", function ()
              dap.set_exception_breakpoints({})
            end,
            desc = "Desabilita breakpoint em exceções",
            icon = { icon = "", color = "red" }
          },
        },
      })
      -- Configura nvim-dap-ui
      dapui.setup({
        controls = {
          element = "repl",
          enabled = false,
        },
      })
      -- Abre UI automaticamente ao iniciar debugger
      dap.listeners.before.launch.dapui_config = dapui.open
      dap.listeners.before.attach.dapui_config = dapui.open

      -- Limpa linha de comando
      dap.listeners.before.event_initialized.dapui_config = function ()
        print(" ")
      end

      dap.listeners.after.event_exited.dapui_config = function ()
        vim.notify("Debugger encerrado", vim.log.levels.INFO)
      end
    end
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    lazy = true,
    ft = "python",
  },
}
