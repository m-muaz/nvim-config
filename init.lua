require "user.options" 
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.gitsigns"
require "user.treesitter"
require "user.autopairs"
require "user.comment"
require "user.nvim-tree"
require "user.bufferline"
require "user.lualine"
require "user.toggleterm"
require "user.project"
require "user.impatient"
require "user.indentline"
require "user.alpha"
require "user.whichkey"
require "user.autocommands"
require "user.trouble"
require "user.TODO"
-- require "user.lsp_zero"
require "user.LuaSnip"


-- Configuring cmake-language-server as a language server for cmake

if vim.fn.executable('cmake-language-server') == 1 then
  require('lspconfig').cmake.setup{
    cmd = { 'cmake-language-server' },
    root_dir = function()
      return vim.fn.getcwd()
    end,
    whitelist = { 'cmake' },
    init_options = {
      buildDirectory = 'build',
    },
  }
end
