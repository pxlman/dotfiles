-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	-- use {
	--     'nvim-telescope/telescope.nvim', tag = '0.1.2',
	--     -- or                            , branch = '0.1.x',
	--     requires = { {'nvim-lua/plenary.nvim'} }
	-- }
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("nvim-treesitter/playground")

	-- Themes
	use({ "rose-pine/neovim", as = "rose-pine" })
	use({ "rebelot/kanagawa.nvim", as = "kanagawa" })
	use({ "bluz71/vim-moonfly-colors", as = "moonfly" })
	use({ "folke/tokyonight.nvim", as = "tokyonight" })
	-- use("xiyaowong/transparent.nvim")
	use({ "nyoom-engineering/oxocarbon.nvim" })

	-- lualine

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	use("nvim-tree/nvim-web-devicons")

	-- formatting & linting
	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- essential plugins
	use("tpope/vim-surround") -- add, delete, change surroundings

	use("inkarkat/vim-ReplaceWithRegister") -- replace with register contents using motion (gr + motion)

	use("nvim-lua/plenary.nvim") -- dependency
	use("szw/vim-maximizer") -- maximizes and restores current window
	-- comment
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- file explorer
	use("nvim-tree/nvim-tree.lua")

	-- fuzzy finding w/ telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- autocompletion
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	use("lukas-reineke/indent-blankline.nvim")
	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets
	-- require("luasnip").add_snippets("cpp", )
	-- managing & installing lsp servers, linters & formatters
	use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	use("neovim/nvim-lspconfig") -- easily configure language servers
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		requires = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	}) -- enhanced lsp uis
	use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	-- yabs for code runner
	--
	-- use("CRAG666/code_runner.nvim") -- code runner
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }) -- debugger ui
	use("ldelossa/nvim-dap-projects") -- to configure nvim-dap
	use("theHamsta/nvim-dap-virtual-text")

	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup()
		end,
	}) -- main debugger

	-- neorg
	use({
		"nvim-neorg/neorg",
		ft = "nord",
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					["core.concealer"] = {}, -- Adds pretty icons to your documents
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								notes = "~/notes",
							},
						},
					},
				},
			})
		end,
		run = ":Neorg sync-parsers",
		requires = "nvim-lua/plenary.nvim",
	})
	use("mattn/emmet-vim")
	use({
		"ziontee113/color-picker.nvim",
		config = function()
			require("color-picker")
		end,
	})
end)
