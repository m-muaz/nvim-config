local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
  return
else
  require("copilot").setup()
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	["a"] = { "<cmd>Alpha<cr>", "Alpha" },
	["b"] = {
		"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = true})<cr>",
		"Buffers",
	},
	-- ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	["e"] = { "<Cmd>Neotree toggle<CR>", "Neotree" },
	["w"] = { "<cmd>w!<CR>", "Save" },
	["q"] = { "<cmd>q!<CR>", "Quit" },
	c = {
		name = "Copilot & Buffer Close",
		c = { "<cmd>Bdelete!<CR>", "Close Buffer" },
		e = { "<cmd>Copilot enable<CR>", "Enable Copilot", { silent = true, expr = true } },
		d = { "<cmd>Copilot disable<CR>", "Disable Copilot", { silent = true, expr = true } },
		s = { "<cmd>Copilot status<CR>", "Copilot Status" },
    p = {"<cmd>Copilot panel<CR>", "Copilot panel"},
		-- j = { "<cmd>Copilot next<CR>", "Next Suggestion" },
		-- k = { "<cmd>Copilot prev<CR>", "Prev Suggestion" },
		-- a = { "<cmd>Copilot accept<CR>", "Accept Suggestion" },
		-- x = { "<cmd>Copilot dismiss<CR>", "Dismiss Suggestion" },
		-- g = { "<cmd>Copilot generate<CR>", "Generate Suggestion" },
	},
	["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	["u"] = { "<cmd>ASToggle<CR>", "Auto Save Toggle" },
	m = {
		name = "Mason",
		m = {
			"<cmd>Mason<cr>",
			"Mason Install",
		},
		l = {
			"<cmd>MasonLog<cr>",
			"Mason Log",
		},
		u = {
			"<cmd>MasonUpdate<cr>",
			"Mason Update",
		},
		d = {
			"<cmd>MasonUninstall<cr>",
			"Mason Uninstall",
		},
		U = {
			"<cmd>MasonUninstallAll",
			"Mason Uninstall All",
		},
	},
	f = {
		name = "Telescope",
		b = {
			"<cmd>Telescope current_buffer_fuzzy_find<cr>",
			"Fuzzy Find in Buffer",
		},
		f = {
			"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{winblend=20})<cr>",
			"Find files",
		},
		F = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
		P = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
	},

	p = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},

	d = {
		name = " Debugger",
		S = {
			function()
				require("dap").continue()
			end,
			"Debugger: Start",
		},
		x = {
			function()
				require("dap").terminate()
			end,
			"Debugger: Stop",
		},
		C = {
			function()
				vim.ui.input({ prompt = "Condition: " }, function(condition)
					if condition then
						require("dap").set_breakpoint(condition)
					end
				end)
			end,
			"Debugger: Conditional Breakpoint",
		},
		r = {
			function()
				require("dap").restart_frame()
			end,
			"Debugger: Restart",
		},

		p = {
			function()
				require("dap").pause()
			end,
			"Debugger: Pause",
		},

		b = {
			function()
				require("dap").toggle_breakpoint()
			end,
			"Debugger: Toggle Breakpoint",
		},
		s = {
			name = "Step ...",
			o = {
				function()
					require("dap").step_over()
				end,
				"Debugger: Step Over",
			},
			i = {
				function()
					require("dap").step_into()
				end,
				"Debugger: Step Into",
			},
			O = {
				function()
					require("dap").step_out()
				end,
				"Debugger: Step Out",
			},
		},

		c = {
			name = "Breakpoint",
			b = {
				function()
					require("dap").clear_breakpoints()
				end,
				"Debugger: Clear Breakpoints",
			},
		},
		d = {
			name = "Session ...",
			q = {
				function()
					require("dap").close()
				end,
				"Close Session",
			},
			Q = {
				function()
					require("dap").terminate()
				end,
				"Debugger: Terminate Session",
			},
			R = {
				function()
					require("dap").repl.toggle()
				end,
				"Toggle REPL",
			},
			s = {
				function()
					require("dap").run_to_cursor()
				end,
				"Run To Cursor",
			},
		},
	},

	g = {
		name = "Git",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
	},

	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = {
			"<cmd>Telescope diagnostics bufnr=0<cr>",
			"Document Diagnostics",
		},
		w = {
			"<cmd>Telescope diagnostics<cr>",
			"Workspace Diagnostics",
		},
		f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		j = {
			"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
			"Prev Diagnostic",
		},
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
	},
	s = {
		name = "Search",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
	},

	v = {
		name = "VimTex",
		r = { "<cmd>VimtexReload<cr>", "Reload VimTex" },
		c = { "<cmd>VimtexCompile<cr>", "Continuous Compile" },
	},

	t = {
		name = "Terminal",
		n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
		c = { "<cmd>TodoTelescope<cr>", "TodoTelescope" },
	},
}

which_key.setup(setup)
which_key.register(mappings, opts)
