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
            "nixfmt",
            "stylua",
            "alejandra",
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
      -- vim.lsp.servers.nixd.settings.nil_ls.nix.autoArchive = true;
      -- vim.lsp.servers.nixd.settings.nil_ls.autoArchive = true; -- To auto fetch inputs for nix files
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
  },
}
