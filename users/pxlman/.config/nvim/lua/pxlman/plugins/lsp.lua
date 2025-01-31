return {
  {
    "williamboman/mason.nvim",
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
        "marksman",
        "html",
        "gopls",
        "eslint"
      },
      automatic_installation = false,
    },
  },
  -- To config each lsp server individually
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require("lspconfig").clangd.setup{
        capabilities = capabilities
      }
      require("lspconfig").pyright.setup{
        capabilities = capabilities
      }
      require("lspconfig").html.setup{
        capabilities = capabilities
      }
      require("lspconfig").gopls.setup{
        capabilities = capabilities
      }
      require("lspconfig").eslint.setup{
        capabilities = capabilities
      }
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
  },
}
