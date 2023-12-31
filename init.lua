require("user.options")
require("user.keymaps")
require("user.plugins")
require("user.colorscheme")
require("user.cmp")
require("user.lsp")
require("user.telescope")
require("user.gitsigns")
-- require("user.treesitter")
require("user.autopairs")
require("user.comment")
-- require "user.nvim-tree"
require("user.bufferline")
require("user.lualine")
require("user.toggleterm")
require("user.project")
require("user.impatient")
require("user.indentline")
require("user.alpha")
require("user.whichkey")
require("user.autocommands")
require("user.trouble")
require("user.TODO")
-- require "user.lsp_zero"
require("user.LuaSnip")
require("user.notify")
require("user.neotree")
require("user.nvim-dap")
require("user.cmake-nvim")


-- colorscheme
-- vim.cmd('colorscheme catppuccin-mocha')
vim.cmd([[colorscheme catppuccin-mocha]])


-- Enable mouse support
vim.o.mouse = "a"
