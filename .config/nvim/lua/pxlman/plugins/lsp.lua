return {
    {
        "williamboman/mason.nvim",
        -- [[
        -- install by:    i
        -- uninstall by : <S-x>
        -- ]]
        opts = {
            plugin = true,
            ensure_installed = {
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
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "clangd",
                "pyright",
                "lua_ls",
            },
            automatic_installation = true,
        },
    },
    -- To config each lsp server individually
    {
        "neovim/nvim-lspconfig",
	config = function()
	   require("lspconfig").clangd.setup{}
	   require("lspconfig").pyright.setup{}

	end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
    },
}
