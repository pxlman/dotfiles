local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_null_ls = require("mason-null-ls")

-- enable mason
mason.setup({
	plugin = true,
	ensure_installed = {
		"tsserver",
		"html",
		"cssls",
		"clangd",
		"codelldb",
		"cpptools",
		"cpplint",
		"bashls",
		"ltex",
		"marksman",
		"pyright",
		"tailwindcss",
		"lua_ls",
		"emmet_ls",
	},
	automatic_installation = true, -- not the same as ensure_installed
})

mason_lspconfig.setup({
	-- list of servers for mason to install
	-- ensure_installed = {
	-- 	"tsserver",
	-- 	"html",
	-- 	"cssls",
	-- 	"clangd",
	-- 	"codelldb",
	-- 	"bashls",
	-- 	"ltex",
	-- 	"marksman",
	-- 	"pyright",
	-- 	"tailwindcss",
	-- 	"lua_ls",
	-- 	"emmet_ls",
	-- },
	-- auto-install configured servers (with lspconfig)
	automatic_installation = true, -- not the same as ensure_installed
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"prettier", -- ts/js formatter
		"stylua", -- lua formatter
		"eslint_d", -- ts/js linter
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})
