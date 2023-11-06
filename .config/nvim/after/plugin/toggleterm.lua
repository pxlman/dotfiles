require("toggleterm").setup({
	-- size can be a number or function which is passed the current terminal
	size = function(term)
		if term.direction == "horizontal" then
			return 8
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
	open_mapping = [[<c-\>]],
	hide_numbers = true, -- hide the number column in toggleterm buffers
	autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
	dir = vim.fn.expand("%:p:h"),
	start_in_insert = true,
	-- persist_size = true,
	-- persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
	direction = "float",
	-- close_on_exit = true, -- close the terminal window when the process exits
	-- Change the default shell. Can be a string or a function returning a string
	-- shell = vim.o.shell,
	auto_scroll = true, -- automatically scroll to the bottom on terminal output
	-- This field is only relevant if direction is set to 'float'
	float_opts = {
		-- The border key is *almost* the same as 'nvim_open_win'
		-- see :h nvim_open_win for details on borders however
		-- the 'curved' order is a custom border type
		-- not natively supported but implemented in this plugin.
		-- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
		border = "single",
		-- like `size`, width and height can be a number or function which is passed the current terminal
		-- width = <value>,
		height = 13,
		-- winblend = 3,
		-- zindex = <value>,
	},
	winbar = {
		enabled = true,
		name_formatter = function(term) --  term: Terminal
			return term.name
		end,
	},
})
