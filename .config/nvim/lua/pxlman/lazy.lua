local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
	"git",
	"clone",
	"--filter=blob:none",
	"https://github.com/folke/lazy.nvim.git",
	"--branch=stable", -- latest stable release
	lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
plugins = {
    -- Colorscheme
    {
	"Shatur/neovim-ayu",
	lazy = false,
	priority = 2000,
	config = function()
	    vim.cmd("colorscheme ayu-dark")
	end
    },
    -- A dependency for many plugins
    -- contain a helpful functions for plugins
    "nvim-lua/plenary.nvim",
    -- Nvim Tree
    {
	"nvim-tree/nvim-tree.lua",
	dependencies = {"nvim-tree/nvim-web-devicons"},
	config = function()
	    -- disable netrw at the very start of your init.lua
	    vim.g.loaded_netrw = 1
	    vim.g.loaded_netrwPlugin = 1

	    -- optionally enable 24-bit colour
	    vim.opt.termguicolors = true
	    -- OR setup with some options
	    require("nvim-tree").setup{
		view = {
		    width = 10,
		},
		update_focused_file = {
		    enable = true,
		    update_root = true,
		},
	    }
	end
    },
    -- To recommend key to press
    "folke/which-key.nvim",
    -- A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing.
    {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
	    require("trouble").setup{
		icons = false,
	    }
	end,
    },
    -- Move with the lines
    {
	"hinell/move.nvim",

    },
    -- Gaze deeply into unknown regions using the power of the moon.
    {
	"nvim-telescope/telescope.nvim",
	dependencies = { 'nvim-lua/plenary.nvim' },
    },

    -- Neorg for org mode in neovim
    {
	"nvim-neorg/neorg",
	-- lazy-load on filetype
	ft = "norg",
	-- options for neorg. This will automatically call `require("neorg").setup(opts)`
	opts = {
	    load = {
		["core.defaults"] = {},
	    },
	},
    },
    -- I thinks it's to reduce startup time
    {
	"dstein64/vim-startuptime",
	-- lazy-load on a command
	cmd = "StartupTime",
	-- init is called during startup. Configuration for vim plugins typically should be set in an init function
	init = function()
	    vim.g.startuptime_tries = 10
	end,
    },
    {
	'windwp/nvim-autopairs',
	event = "InsertEnter",
	config = true,
	opts = {
	    map_cr = true,
	    map_bs = true ,   -- map the <BS> key
	    map_c_w = false,  -- map <c-w> to delete a pair if possible
	    map_c_h = false,  -- Map the <C-h> key to delete a pair
	}
	-- use opts = {} for passing setup options
	-- this is equalent to setup({}) function
    },
    -- Floating terminal
    {
	"voldikss/vim-floaterm",
    },
    -- Treesitter for highlighting the text more
    {
	'nvim-treesitter/nvim-treesitter',
	config = function()
	    require("nvim-treesitter.configs").setup{
		ensure_installed = {"c",'cpp','python','lua','bash','javascript','html','css','markdown','norg'},
		highlight = {
		    enable = true,
		},
	    }
	end
    },
    {
	"williamboman/mason.nvim",
	config = function()
	    require("mason").setup {
		plugin = true,
		ensure_installed = {
		    lsp = {
			"clangd",
			"pyright",
		    },
		    dap = {
			"cpptools"
		    },
		    linter = {
		    },
		    formatter = {
			"prettier"
		    }
		},
		automatic_installation = true,
	    }
	end
    },
    -- To config each lsp server individually
    {
	"neovim/nvim-lspconfig",
	config = function()
	   require("lspconfig").clangd.setup{}
	   require("lspconfig").pyright.setup{}

	end,
    },
}
opts = {}
require("lazy").setup(plugins,opts)
