function map(mode,key,cmd,desc)
  vim.keymap.set(mode,key,cmd,{desc = desc,silent = true})
end
return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      map("n","<Leader>db",":DapToggleBreakpoint<CR>","[D]ebugger [B]reakPoint")
      map("n","<Leader>dk",":DapContinue<CR>","[D]ebugger [C]ontinue")
      -- dap.adapters.python = {
      --   type = "executable",
      --   command = "python",
      --   args = { "-i", "dap" }
      -- }
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" }
      }
      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            -- return vim.fn.input('Path to executable: ', vim.fn.expand("%<"), 'file')
            -- return vim.fn.input('Path to executable: ', "/tmp/m", 'file')
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
      }
      dap.configurations.python = {
        {
          type = 'python';
          request = 'launch';
          name = "Launch file";
          program = "${file}";
          pythonPath = function()
            return '/usr/bin/python'
          end;
        },
      }
    end
  },
  { 
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap", 
      "nvim-neotest/nvim-nio"
    },
    config = function()
      local dapui = require('dapui')
      dapui.setup{
        layouts = {
          {
            elements = {
              {
                id = "scopes",
                size = 0.25,
              },
              {
                id = "breakpoints",
                size = 0.25,
              },
              {
                id = "stacks",
                size = 0.25,
              },
              {
                id = "watches",
                size = 0.25,
              },
            },
            position = "left",
            size = 25,
            -- width = 2,
          },
          {
            elements = { {
              id = "repl",
              size = 0.5,
            }, {
              id = "console",
              size = 0.5,
            } },
            position = "bottom",
            size = 8,
          },
        },
      }
      map("n","<Leader>du",
      function()
        dapui.toggle()
      end,"[D]ap [U]i")
    end,
  }
}
