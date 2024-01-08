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
-- require("user.notify")
require("user.neotree")
require("user.nvim-dap")
require("user.cmake-nvim")
require("user.dap-virtual")

-- colorscheme
-- vim.cmd('colorscheme catppuccin-mocha')
vim.cmd([[colorscheme catppuccin-mocha]])

-- -- Setting OSC Vim plugin to allow copying over ssh to windows terminal
vim.keymap.set('n', '<leader>x', require('osc52').copy_operator, {expr = true})
vim.keymap.set('n', '<leader>xx', '<leader>c_', {remap = true})
vim.keymap.set('v', '<leader>x', require('osc52').copy_visual)

-- Enable mouse support
vim.o.mouse = "a"
