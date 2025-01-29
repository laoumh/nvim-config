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
    version = "*",
      { "rcarriga/nvim-dap-ui" , version = "*"},
      { "nvim-neotest/nvim-nio", version = "*"},
    },
    ft = {"python"},
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- [[ CONFIGURA APARÊNCIA ]]
      vim.fn.sign_define('DapBreakpoint', {text='', texthl='', linehl='', numhl=''})
      vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='', linehl='', numhl=''})
      vim.fn.sign_define('DapStopped', {text='', texthl='', linehl='Cursor', numhl=''})

      dapui.setup({
        controls = {
          element = "repl",
          -- Não mostra ícones de debug no REPL
          enabled = false,
        },
      })

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
              for _, session in pairs(dap.sessions()) do
                session:disconnect()
              end
              dapui.close()
            end,
            desc = "Stop (disconnect all sessions)", icon = {icon = "", color = "red"}
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
      -- Controla Painéis
      wk.add({
        { "<leader>dp", group = "Control UI Panels", icon = { icon = "󱂬", color = "yellow" }, mode = "n" },
        {
          mode = "n",
          -- Abre painéis dapui
          { "<leader>dpo", function ()
              dapui.open({ reset = true })
            end,
            desc = "Open all panels",
            icon = { icon = "󰏋", color = "green" }
          },
          -- Fecha painéis dapui
          { "<leader>dpc", function ()
              dapui.close()
            end,
            desc = "Close all panels",
            icon = { icon = "", color = "red" }
          },
          { "<leader>dpl", function ()
              dapui.toggle({ layout = 1, reset = true })
            end,
            desc = "Toggle left panel",
            icon = { icon = "󱂪", color = "yellow" }
          },
          { "<leader>dpb", function ()
              dapui.toggle({ layout = 2, reset = true })
            end,
            desc = "Toggle bottom panel",
            icon = { icon = "󱂩", color = "yellow" }
          },
        },
      })

      -- [[ CONFIGURA INICIALIZAÇÃO / FINALIZAÇÃO ]]
      local function on_open_config()
        vim.notify_once("Debugger iniciado. Abrir DAP UI se necessário.")
      end
      dap.listeners.before.launch.dapui_config = on_open_config
      dap.listeners.before.attach.dapui_config = on_open_config
      -- Limpa linha de comando
      dap.listeners.before.event_initialized.dapui_config = function ()
        print(" ")
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
