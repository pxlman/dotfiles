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
          "prettier",
          "nixfmt"
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
        "eslint",
        "jdtls"
      },
      automatic_installation = true,
    },
  },
  -- To config each lsp server individually
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      vim.lsp.config.clangd = {
        capabilities = capabilities
      }
      vim.lsp.config.nil_ls = {
        capabilities = capabilities,
        autoArchive = true,
      }
      vim.lsp.config.pyright = {
        capabilities = capabilities
      }
      vim.lsp.config('jdtls',{ capabilities = capabilities, cmd = { 'jdtls' } })
      vim.lsp.config.html = {
        capabilities = capabilities
      }
      vim.lsp.config.gopls = {
        capabilities = capabilities
      }
      vim.lsp.config.eslint = {
        capabilities = capabilities
      }
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
        vim.null_ls.config.sources = {
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.formatting.nixfmt,
        };
        end,
  },
}
