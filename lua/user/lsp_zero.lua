local status_ok, _ = pcall(require, "lsp-zero")
if not status_ok then
  return
end
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup()

