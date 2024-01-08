local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    " autocmd BufWritePost plugins.lua source <afile> | PackerSync
    autocmd BufWritePost plugins.lua source <afile>
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  use({ "wbthomason/packer.nvim", commit = "6afb67460283f0e990d35d229fd38fdc04063e0a" }) -- Have packer manage itself
  use({ "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" })  -- Useful lua functions used by lots of plugins
  -- use { "windwp/nvim-autopairs", commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347" } -- Autopairs, integrates with both cmp and treesitter
  use({ "numToStr/Comment.nvim", commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67" })
  use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "4d3a68c41a53add8804f471fcc49bb398fe8de08" })
  -- use { "kyazdani42/nvim-web-devicons", commit = "563f3635c2d8a7be7933b9e547f7c178ba0d4352" }
  use({ "nvim-tree/nvim-web-devicons" })
  -- use {
  --   'nvim-tree/nvim-tree.lua',
  --   requires = {
  --     'nvim-tree/nvim-web-devicons', -- optional
  --   },
  -- }
  -- use { "kyazdani42/nvim-tree.lua", commit = "7282f7de8aedf861fe0162a559fc2b214383c51c" }
  use({ "akinsho/bufferline.nvim", commit = "83bf4dc7bff642e145c8b4547aa596803a8b4dc4" })
  use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
  use({ "nvim-lualine/lualine.nvim", commit = "a52f078026b27694d2290e34efa61a6e4a690621" })
  use({ "akinsho/toggleterm.nvim", commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda" })
  use({ "ahmedkhalf/project.nvim", commit = "628de7e433dd503e782831fe150bb750e56e55d6" })
  use({ "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" })
  --  use { "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" }
  use({ "goolord/alpha-nvim", commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31" })
  use({ "folke/which-key.nvim" })
  use({ "tpope/vim-surround" })

  -- Add plugin for indent blankline
  use({ "lukas-reineke/indent-blankline.nvim" })

  -- Colorschemes
  use({ "folke/tokyonight.nvim", commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764" })
  use({ "lunarvim/darkplus.nvim", commit = "13ef9daad28d3cf6c5e793acfc16ddbf456e1c83" })
  use({ "rebelot/kanagawa.nvim" })
  use({ "catppuccin/nvim", as = "catppuccin" })
  use({
    "ellisonleao/gruvbox.nvim", -- theme,
    -- priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        palette_overrides = { dark0_hard = "#0E1018" },
        overrides = {
          -- Comment = {fg = "#626A73", italic = true, bold = true},
          -- #736B62,  #626273, #627273
          Comment = { fg = "#81878f", italic = true, bold = true },
          Define = { link = "GruvboxPurple" },
          Macro = { link = "GruvboxPurple" },
          ["@constant.builtin"] = { link = "GruvboxPurple" },
          ["@storageclass.lifetime"] = { link = "GruvboxAqua" },
          ["@text.note"] = { link = "TODO" },
          ["@namespace.latex"] = { link = "Include" },
          ["@namespace.rust"] = { link = "Include" },
          ContextVt = { fg = "#878788" },
          CopilotSuggestion = { fg = "#878787" },
          CocCodeLens = { fg = "#878787" },
          CocWarningFloat = { fg = "#dfaf87" },
          CocInlayHint = { fg = "#ABB0B6" },
          CocPumShortcut = { fg = "#fe8019" },
          CocPumDetail = { fg = "#fe8019" },
          DiagnosticVirtualTextWarn = { fg = "#dfaf87" },
          -- fold
          Folded = { fg = "#fe8019", bg = "#3c3836", italic = true },
          FoldColumn = { fg = "#fe8019", bg = "#0E1018" },
          SignColumn = { bg = "#fe8019" },
          -- new git colors
          DiffAdd = { bold = true, reverse = false, fg = "", bg = "#2a4333" },
          DiffChange = { bold = true, reverse = false, fg = "", bg = "#333841" },
          DiffDelete = { bold = true, reverse = false, fg = "#442d30", bg = "#442d30" },
          DiffText = { bold = true, reverse = false, fg = "", bg = "#213352" },
          -- statusline
          StatusLine = { bg = "#ffffff", fg = "#0E1018" },
          StatusLineNC = { bg = "#3c3836", fg = "#0E1018" },
          CursorLineNr = { fg = "#fabd2f", bg = "" },
          GruvboxOrangeSign = { fg = "#dfaf87", bg = "" },
          GruvboxAquaSign = { fg = "#8EC07C", bg = "" },
          GruvboxGreenSign = { fg = "#b8bb26", bg = "" },
          GruvboxRedSign = { fg = "#fb4934", bg = "" },
          GruvboxBlueSign = { fg = "#83a598", bg = "" },
          WilderMenu = { fg = "#ebdbb2", bg = "" },
          WilderAccent = { fg = "#f4468f", bg = "" },
          -- coc semantic token
          CocSemStruct = { link = "GruvboxYellow" },
          CocSemKeyword = { fg = "", bg = "#0E1018" },
          CocSemEnumMember = { fg = "", bg = "#0E1018" },
          CocSemTypeParameter = { fg = "", bg = "#0E1018" },
          CocSemComment = { fg = "", bg = "#0E1018" },
          CocSemMacro = { fg = "", bg = "#0E1018" },
          CocSemVariable = { fg = "", bg = "#0E1018" },
          -- CocSemFunction = {link = "GruvboxGreen"},
          -- neorg
          ["@neorg.markup.inline_macro"] = { link = "GruvboxGreen" },
        },
      })
      -- vim.cmd.colorscheme("gruvbox")
    end,
  })

  -- Custom plugins
  -- Neorg plugin
  use {
    "nvim-neorg/neorg",
    config = function()
      require('neorg').setup {
        load = {
          ["core.defaults"] = {},        -- Loads default behaviour
          ["core.concealer"] = {},       -- Adds pretty icons to your documents
          ["core.dirman"] = {            -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
              },
            },
          },
        },
      }
    end,
    run = ":Neorg sync-parsers",
    requires = "nvim-lua/plenary.nvim",
  }

  -- Barbecue.nvim
  use({
    "utilyre/barbecue.nvim",
    tag = "*",
    requires = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
      require("barbecue").setup({
        theme = {
          -- this highlight is used to override other highlights
          -- you can take advantage of its `bg` and set a background throughout your winbar
          -- (e.g. basename will look like this: { fg = "#c0caf5", bold = true })
          normal = { fg = "#c0caf5" },
          -- these highlights correspond to symbols table from config
          ellipsis = { fg = "#737aa2" },
          separator = { fg = "#737aa2" },
          modified = { fg = "#737aa2" },
          -- these highlights represent the _text_ of three main parts of barbecue
          dirname = { fg = "#737aa2" },
          basename = { bold = true },
          context = {},
          -- these highlights are used for context/navic icons
          context_file = { fg = "#ac8fe4" },
          context_module = { fg = "#ac8fe4" },
          context_namespace = { fg = "#ac8fe4" },
          context_package = { fg = "#ac8fe4" },
          context_class = { fg = "#ac8fe4" },
          context_method = { fg = "#ac8fe4" },
          context_property = { fg = "#ac8fe4" },
          context_field = { fg = "#ac8fe4" },
          context_constructor = { fg = "#ac8fe4" },
          context_enum = { fg = "#ac8fe4" },
          context_interface = { fg = "#ac8fe4" },
          context_function = { fg = "#ac8fe4" },
          context_variable = { fg = "#ac8fe4" },
          context_constant = { fg = "#ac8fe4" },
          context_string = { fg = "#ac8fe4" },
          context_number = { fg = "#ac8fe4" },
          context_boolean = { fg = "#ac8fe4" },
          context_array = { fg = "#ac8fe4" },
          context_object = { fg = "#ac8fe4" },
          context_key = { fg = "#ac8fe4" },
          context_null = { fg = "#ac8fe4" },
          context_enum_member = { fg = "#ac8fe4" },
          context_struct = { fg = "#ac8fe4" },
          context_event = { fg = "#ac8fe4" },
          context_operator = { fg = "#ac8fe4" },
          context_type_parameter = { fg = "#ac8fe4" },
        },
        create_autocmd = false,
      })
    end,
  })

  -- Vim-tmux-navigator plugin
  use({ "christoomey/Vim-tmux-navigator" })
  -- Trouble.nvim
  use({
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
  })

  -- Nvim DAP (Debug Adapter Protocol)
  use({
    "mfussenegger/nvim-dap",
    requires = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
    },
  })
  use({
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup({
        library = { plugins = { "nvim-dap-ui" }, types = true },
      })
    end,
  })
  -- Nvim DAP UI
  use({
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
    -- config = function ()
    --       local dap = require("dap")
    --       local dapui = require("dapui")
    --
    --
    -- end
  })
  use({ "theHamsta/nvim-dap-virtual-text" })

  use({ "Civitasv/cmake-tools.nvim" })

  -- Vim Tex plugin
  use({ "lervag/vimtex" })

  -- Vim notify
  -- use({ "rcarriga/nvim-notify" })

  -- Eyeline
  use({
    "jinh0/eyeliner.nvim",
    config = function()
      require("eyeliner").setup({
        highlight_on_key = true, -- show highlights only after keypress
        dim = true,              -- dim all other characters if set to true (recommended!)
      })
    end,
  })

  -- Neo-tree plugin
  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      {
        -- only needed if you want to use the commands with "_with_window_picker" suffix
        "s1n7ax/nvim-window-picker",
        tag = "v1.*",
        config = function()
          require("window-picker").setup({
            autoselect_one = true,
            include_current = false,
            filter_rules = {
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                -- if the buffer type is one of following, the window will be ignored
                buftype = { "terminal", "quickfix" },
              },
            },
            other_win_hl_color = "#e35e4f",
          })
        end,
      },
    },
    config = function()
      -- Unless you are still migrating, remove the deprecated commands from v1.x
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
      -- NOTE: this is changed from v1.x, which used the old style of highlight groups
      -- in the form "LspDiagnosticsSignWarning"
    end,
  })

  -- -- Unless you are still migrating, remove the deprecated commands from v1.x
  -- vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  -- use {
  --   "n'folke/neodev.nvim'vim-neo-tree/neo-tree.nvim",
  --     branch = "v2.x",
  --     requires = {
  --       "nvim-lua/plenary.nvim",
  --       "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --       "MunifTanjim/nui.nvim",
  --     }
  --   }

  -- TODO.nvim
  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
  })
  -- Cmp
  use({ "hrsh7th/nvim-cmp", commit = "b0dff0ec4f2748626aae13f011d1a47071fe9abc" })         -- The completion plugin
  use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" })       -- buffer completions
  use({ "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" })         -- path completions
  use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
  use({ "hrsh7th/cmp-nvim-lsp", commit = "3cf38d9c957e95c397b66f91967758b31be4abe6" })
  use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })

  -- Snippets
  use({ "L3MON4D3/LuaSnip", commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84" })             --snippet engine
  use({ "rafamadriz/friendly-snippets", commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1" }) -- a bunch of snippets to use

  -- LSP
  use({
    "williamboman/mason.nvim",
    run = ":MasonUpdate", -- :MasonUpdate updates registry contents
  })
  -- use { "williamboman/mason.nvim",
  --   -- commit = "c2002d7a6b5a72ba02388548cfaf420b864fbc12",
  --   run = ":MasonUpdate"
  -- } -- simple to use language server installer
  use({ "williamboman/mason-lspconfig.nvim" })
  -- use { "williamboman/mason-lspconfig.nvim", commit = "0051870dd728f4988110a1b2d47f4a4510213e31" }
  use({ "neovim/nvim-lspconfig" })
  -- use { "neovim/nvim-lspconfig", commit = "f11fdff7e8b5b415e5ef1837bdcdd37ea6764dda" } -- enable LSP
  use({ "jose-elias-alvarez/null-ls.nvim", commit = "c0c19f32b614b3921e17886c541c13a72748d450" }) -- for formatters and linters
  use({ "RRethy/vim-illuminate", commit = "a2e8476af3f3e993bb0d6477438aad3096512e42" })

  -- Lsp-zero plugin
  use({
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    requires = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      {
        -- Optional
        "williamboman/mason.nvim",
        run = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
      },
      { "williamboman/mason-lspconfig.nvim" }, -- Optional

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },     -- Required
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "L3MON4D3/LuaSnip" },     -- Required
    },
  })

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    -- or                            , branch = '0.1.x',
    requires = { { "nvim-lua/plenary.nvim" } },
  })
  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac",
  })

  use({
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        enabled = false,
        -- your config goes here
        -- or just leave it empty :)
      })
    end,
  })

  -- One dark colorscheme

  use({
    "navarasu/onedark.nvim",
    config = function()
      local colors = {
        black = "#000000",
        bg_d = "#0a0d11",
        bg0 = "#101317",
        bg1 = "#13161a",
        bg2 = "#171b20",
        bg3 = "#1b1f25",
        ColorColumn = "#43262a",
        Whitespace = "#262a30",
        IndentBlanklineSpaceChar = "#262a30",
        FloatBorder = "#101317",
        NvimTreeIndentMarker = "#262a30",
      }
      local ts_colors = {
        white = "#ffffff",
        yellow = "#cfcf60",
        red = "#af3030",
        green = "#303fa0",
        darker_black = "#070a0e",
        black = "#0a0d11",
        black2 = "#171b20",
      }
      require("onedark").setup({
        style = "darker",
        colors = colors,
        highlights = {
          ColorColumn = { bg = colors.ColorColumn },
          Whitespace = { fg = colors.Whitespace },
          IndentBlanklineSpaceChar = { fg = colors.IndentBlanklineSpaceChar },
          FloatBorder = { bg = colors.FloatBorder },
          NvimTreeIndentMarker = { fg = colors.NvimTreeIndentMarker },
          TelescopeBorder = { fg = ts_colors.darker_black, bg = ts_colors.darker_black },
          TelescopeNormal = { bg = ts_colors.darker_black },
          TelescopeSelection = { bg = ts_colors.black2, fg = ts_colors.white },
          TelescopePromptTitle = { fg = ts_colors.white, bg = ts_colors.red },
          TelescopePromptBorder = { fg = ts_colors.black2, bg = ts_colors.black2 },
          TelescopePromptNormal = { fg = ts_colors.white, bg = ts_colors.black2 },
          TelescopePromptPrefix = { fg = ts_colors.red, bg = ts_colors.black2 },
          TelescopePreviewTitle = { fg = ts_colors.white, bg = ts_colors.green },
          TelescopePreviewBorder = { fg = ts_colors.darker_black, bg = ts_colors.darker_black },
          TelescopeResultsTitle = { fg = ts_colors.black, bg = ts_colors.black },
          TelescopeResultsNormal = { bg = ts_colors.black },
          TelescopeResultsBorder = { fg = ts_colors.black, bg = ts_colors.black },
          TelescopeResultsDiffAdd = { fg = ts_colors.green },
          TelescopeResultsDiffChange = { fg = ts_colors.yellow },
          TelescopeResultsDiffDelete = { fg = ts_colors.red },
        },
      })
      -- require("onedark").load()

      -- vim.cmd([[colorscheme onedark]])
    end,
  })


  -- Nvim osc-52
  use {'ojroques/nvim-osc52'}
  -- Git
  use({ "lewis6991/gitsigns.nvim", commit = "2c6f96dda47e55fa07052ce2e2141e8367cbaaf2" })
  -- Lazygit plugin
  -- nvim v0.7.2
  use({
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    requires = {
      "nvim-lua/plenary.nvim",
    },
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
