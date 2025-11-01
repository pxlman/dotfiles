function map(mode,key,cmd,desc)
  vim.keymap.set(mode,key,cmd,{desc = desc,silent = true})
end
plugins = {
  -- Colorscheme
  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 10000,
    config = function()
      vim.cmd("colorscheme ayu-dark")
    end
  },
  -- Lualine for the bottom line
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup{
        options = { theme = 'ayu_dark' }
      }
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' }
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
          width = 30,
        },
        update_focused_file = {
          enable = true,
          update_root = true,
        },
      }
    end
  },
  -- To recommend key to press
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
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
  -- Commentig and uncommenting lines
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  -- Auto pairing
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
  {
    "mattn/emmet-vim", -- type "html:5" or "script" or "input" then press "<C-y>," then it will make the wish 
  },
  -- Floating terminal
  {
    "voldikss/vim-floaterm",
  },
  -- Treesitter for highlighting the text more
  -- {
  --   'nvim-treesitter/nvim-treesitter',
  --   config = function()
  --     require("nvim-treesitter.configs").setup{
  --       ensure_installed = {'python','lua','bash','javascript','html','css','markdown','norg'},
  --       highlight = {
  --         enable = true,
  --       },
  --     }
  --   end
  -- },
  {
    'andweeb/presence.nvim',
    config = function()
      require("presence").setup({
        -- General options
        auto_update         = true,
        neovim_image_text   = "The One True Text Editor",
        main_image          = "neovim",
        client_id           = "793271441293967371",
        log_level           = nil,
        debounce_timeout    = 10,
        enable_line_number  = false,
        blacklist           = {},
        buttons             = true,
        file_assets         = {},
        show_time           = true,

        -- Rich Presence text options
        editing_text        = "Editing %s",
        file_explorer_text  = "Browsing %s",
        git_commit_text     = "Committing changes", 
        plugin_manager_text = "Managing plugins", 
        reading_text        = "Reading %s",
        workspace_text      = "Working on %s",
        line_number_text    = "Line %s out of %s",
      })
    end,
  },
}
return plugins
