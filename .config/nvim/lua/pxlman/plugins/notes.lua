return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    dependencies = {"nvim-lua/plenary.nvim"},
    opts = {
      workspaces = {
        {
          name = "Notes",
          path = "~/Sync/Notes",
        },
        -- {
          --   name = "work",
          --   path = "~/vaults/work",
          -- },
        },
        completion = {
          nvim_cmp = true,
          min_char = 2,
        },
        new_notes_location = "notes_subdir",
        ui = {
          enable = true,
        }
      },

    },
    {
      "vhyrro/luarocks.nvim",
      priority = 1000, -- We'd like this plugin to load first out of the rest
      config = true, -- This automatically runs `require("luarocks-nvim").setup()`
    },
    {
      "nvim-neorg/neorg",
      build = ":Neorg sync-parsers",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("neorg").setup {
          load = {
            ["core.defaults"] = {}, -- Loads default behaviour
            ["core.concealer"] = {}, -- Adds pretty icons to your documents
            ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
              },
              default_workspace = "notes",
            },
          },
        },
      }
    end,
  },
  {
    'vimwiki/vimwiki',
    ft = {'wiki','vimwiki'},
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
