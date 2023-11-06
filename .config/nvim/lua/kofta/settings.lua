local o = vim.o
local g = vim.g
local c = vim.cmd
-- vim.o
-- Set colorscheme after options
-- vim.opt.background = "dark" -- set this to dark or light in oxcarbon
vim.cmd("colorscheme rose-pine-main")

-- Better shape
o.number = true
o.relativenumber = true

-- mouse and cursor
o.mouse = "a"
o.cursorline = true

-- colors and font
o.termguicolors = true
o.syntax = true
--vim.opt.guifont = {"Rubik", "h20"}
--o.guifont="ComicShannsMono Nerd Font Propo"
-- Caskaydia Cove

-- text options
o.wrap = true
o.textwidth = 300

-- tabs options
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.autoindent = true

-- clipbaord from vim to outside by y and d
o.clipboard = "unnamedplus"

-- Better buffer splitting
o.splitright = true
o.splitbelow = true
o.splitkeep = "screen"
o.signcolumn = "yes" -- show sign column so that text doesn't shift
-- take hello-world as one word
vim.opt.iskeyword:append("-")
vim.opt.iskeyword:append("_")

-- search opts
o.smartcase = true
o.ignorecase = true

-- Preserve view while jumping
o.jumpoptions = "view"

-- Remember 50 items in commandline history
o.history = 50

-- Arabic
o.encoding = "utf-8"
o.fileencoding = "utf-8"
-- o.arabicshape = true
o.delcombine = true

-- ftplugin
o.filetype = true

-- end
local dap = require("dap")
dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = "$HOME/.config/nvim/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
}
