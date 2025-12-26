return {
     "mfussenegger/nvim-dap",
     "rcarriga/nvim-dap-ui",
     'theHamsta/nvim-dap-virtual-text',
     dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
     config= function()
         local dap = require('dap')
         dap.adapters.cppdbg = {
             id = 'cppdbg',
             type = 'executable',
             command = '/home/bobywoby/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
         }

         local dapui =  require("dapui")
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
         require("nvim-dap-virtual-text").setup({
             event="VeryLazy",
             ensure_installed = {
                 "codelldb"
             },
             automatic_installation = true
         })

         dap.configurations.cpp = {
             {
                 name = "Launch file",
                 type = "cppdbg",
                 request = "launch",
                 program = function()
                     return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file')
                 end,
                 -- args = function()
                     --      local args_string = vim.fn.input('Arguments: ')
                     --   return vim.split(args_string, " +") -- Split the input string by spaces
                     -- end,
                     cwd = '${workspaceFolder}',
                     stopAtEntry = true,
                 },
                 {
                     name = 'Attach to gdbserver :1234',
                     type = 'cppdbg',
                     request = 'launch',
                     MIMode = 'gdb',
                     miDebuggerServerAddress = 'localhost:1234',
                     miDebuggerPath = '/usr/bin/gdb',
                     cwd = '${workspaceFolder}',
                     program = function()
                         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                     end,
                 },
             }
         end

     }
