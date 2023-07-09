local dap, dapui = require("dap"), require("dapui")

vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })
vim.api.nvim_set_hl(0, "red", { fg = "#ff2300" })
vim.fn.sign_define(
	"DapBreakpoint",
	{ text = "●", texthl = "red", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
	"DapBreakpointCondition",
	{ text = "◆", texthl = "red", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "blue", linehl = "DapStopped", numhl = "DapStopped" })
-- dap.defaults.fallback.force_external_terminal = true

dapui.setup({
	-- layouts = {
	-- 	{
	-- 		elements = {
	-- 			"watches",
	-- 			{ id = "scopes", size = 0.5 },
	-- 			{ id = "repl", size = 0.15 },
	-- 		},
	-- 		size = 79,
	-- 		position = "left",
	-- 	},
	-- 	{
	-- 		elements = {
	-- 			"console",
	-- 		},
	-- 		size = 0.25,
	-- 		position = "bottom",
	-- 	},
	-- },
	controls = {
		-- Requires Neovim nightly (or 0.8 when released)
		enabled = true,
		-- Display controls in this element
		element = "repl",
		icons = {
			pause = "",
			play = "",
			step_into = "",
			step_over = "󰆷",
			step_out = "",
			step_back = "",
			run_last = "↻",
			terminate = "",
		},
	},
	expand_lines = true,
	floating = {
		border = "single",
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	mappings = {
		edit = "e",
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		repl = "r",
		toggle = "t",
	},
	render = {
		indent = 1,
		max_value_lines = 100,
	},
})
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
-- dapui.setup(opts)
