local dap, dapui = require("dap"), require("dapui")
require("nvim-dap-virtual-text").setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- adapters
dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
	name = "lldb",
}

-- configs
dap.configurations.cpp = {
	{
		name = "launch",
		type = "lldb",
		request = "launch",
		cwd = "${fileDirname}",
		program = function()
			-- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. vim.fn.expand("%:r"), "file")
			return vim.fn.input("Path to executable: ", vim.fn.expand("%:r"), "file")
		end,
		stopOnEntry = false,
		args = {},
		runInTerminal = false,
	},
}
dap.configurations.c = dap.configurations.cpp
