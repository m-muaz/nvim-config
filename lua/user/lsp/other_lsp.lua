
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
