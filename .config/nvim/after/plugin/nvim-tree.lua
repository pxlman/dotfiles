-- disable netrw at the very start of your init.lua
-- C-v vertical split
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		width = 15,
		-- float = {
		-- 	enable = true,
		-- 	quit_on_focus_loss = true,
		-- },
	},
	renderer = {
		group_empty = true,
		-- add_trailing = true,
	},
	filters = {
		dotfiles = true,
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
})
