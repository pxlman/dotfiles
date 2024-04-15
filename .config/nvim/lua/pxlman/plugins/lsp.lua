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
                "marksman",
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
          require("lspconfig").clangd.setup{
            capabilities = capabilities
          }
          require("lspconfig").pyright.setup{
            capabilities = capabilities
          }
        end,
      },
      {
        "jose-elias-alvarez/null-ls.nvim",
      },
    }
