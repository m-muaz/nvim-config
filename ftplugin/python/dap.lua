-- Configuration for nvim-dap

local dap = require('dap')
dap.adapters.python = {
  type = 'executable';
  -- command = os.getenv('HOME') .. '/.local/share/nvim/mason/packages/debugpy/venv/bin/python';
  command = '/Users/muhammadmuaz/.local/share/nvim/mason/packages/debugpy/venv/bin/python',
  args = { '-m', 'debugpy.adapter' };
}
dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";

    -- Options for debugpy
    program = "${file}";
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python3'
      end
    end;
  },
}
