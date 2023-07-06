local status_ok, py_dap = pcall(require, "dap-python")
if not status_ok then
  return
end
py_dap.setup("/Users/muhammadmuaz/.local/share/AstroNvim/mason/packages/debugpy/venv/bin/python")
