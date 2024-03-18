-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local status_ok, cmake = pcall(require, "cmake-tools")
if not status_ok then
	return
end

--- Get a list of registered null-ls providers for a given filetype
---@param filetype string the filetype to search null-ls for
---@return table # a table of null-ls sources
function null_ls_providers(filetype)
	local registered = {}
	-- try to load null-ls
	local sources_avail, sources = pcall(require, "null-ls.sources")
	if sources_avail then
		-- get the available sources of a given filetype
		for _, source in ipairs(sources.get_available(filetype)) do
			-- get each source name
			for method in pairs(source.methods) do
				-- print(method)
				registered[method] = registered[method] or {}
				table.insert(registered[method], source.name)
			end
		end
	end
	-- return the found null-ls sources
	return registered
end

--- Get the null-ls sources for a given null-ls method
---@param filetype string the filetype to search null-ls for
---@param method string the null-ls method (check null-ls documentation for available methods)
---@return string[] # the available sources for the given filetype and method
function null_ls_sources(filetype, method)
	-- local methods_avail, methods = pcall(require, "null-ls.methods")
	local methods_avail, methods = pcall(require, "null-ls.methods")
	if not methods_avail then
		-- print("null-ls not found")
		return {}
	end
	return methods_avail and null_ls_providers(filetype)[methods.internal[method]] or {}
end

local icons = require("personal.icons")

-- stylua: ignore
local colors = {
	bg = '#202328',
	fg = '#bbc2cf',
	yellow = '#ECBE7B',
	cyan = '#008080',
	darkblue = '#081633',
	green = '#98be65',
	orange = '#FF8800',
	violet = '#a9a1e1',
	magenta = '#c678dd',
	blue = '#51afef',
	red = '#ec5f67'
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

-- Config
local config = {
	-- options = {
	--   -- Disable sections and component separators
	--   component_separators = '',
	--   section_separators = '',
	--   theme = {
	--     -- We are going to use lualine_c an lualine_x as left and
	--     -- right section. Both are highlighted by c theme .  So we
	--     -- are just setting default looks o statusline
	--     normal = { c = { fg = colors.fg, bg = colors.bg } },
	--     inactive = { c = { fg = colors.fg, bg = colors.bg } },
	--   },
	-- },
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = {
			left = "",
			right = "",
		},
		section_separators = {
			left = "",
			right = "",
		},
		disabled_filetypes = { "alpha", "neo%-tree", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left({
	function()
		return "▊"
	end,
	color = {
		fg = colors.blue,
	}, -- Sets highlighting of component
	padding = {
		left = 0,
		right = 1,
	}, -- We don't need space before this
})

ins_left({
	-- mode component
	function()
		return ""
	end,
	color = function()
		-- auto change color according to neovims mode
		local mode_color = {
			n = colors.red,
			i = colors.green,
			v = colors.blue,
			[""] = colors.blue,
			V = colors.blue,
			c = colors.magenta,
			no = colors.red,
			s = colors.orange,
			S = colors.orange,
			[""] = colors.orange,
			ic = colors.yellow,
			R = colors.violet,
			Rv = colors.violet,
			cv = colors.red,
			ce = colors.red,
			r = colors.cyan,
			rm = colors.cyan,
			["r?"] = colors.cyan,
			["!"] = colors.red,
			t = colors.red,
		}
		return {
			fg = mode_color[vim.fn.mode()],
		}
	end,
	padding = {
		right = 1,
	},
})

ins_left({
	-- filesize component
	"filesize",
	cond = conditions.buffer_not_empty,
})

ins_left({
	"filename",
	cond = conditions.buffer_not_empty,
	color = {
		fg = colors.magenta,
		gui = "bold",
	},
})

ins_left({ "location" })

ins_left({
	"progress",
	color = {
		fg = colors.fg,
		gui = "bold",
	},
})

ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = {
		error = " ",
		warn = " ",
		info = " ",
		hint = "󰌵",
	},
	diagnostics_color = {
		color_error = {
			fg = colors.red,
		},
		color_warn = {
			fg = colors.yellow,
		},
		color_info = {
			fg = colors.cyan,
		},
	},
	on_click = function(n, mouse)
		if n == 1 then
			if mouse == "l" then
				vim.cmd("Telescope diagnostics")
			end
		end
	end,
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left({
	function()
		return "%="
	end,
})

-- Cmake Icons
ins_left({
	function()
		local c_preset = cmake.get_configure_preset()
		return "CMake: [" .. (c_preset and c_preset or "X") .. "]"
	end,
	icon = icons.ui.Search,
	cond = function()
		return cmake.is_cmake_project() and cmake.has_cmake_preset()
	end,
	on_click = function(n, mouse)
		if n == 1 then
			if mouse == "l" then
				vim.cmd("CMakeSelectConfigurePreset")
			end
		end
	end,
})

ins_left({
	function()
		local type = cmake.get_build_type()
		return "CMake: [" .. (type and type or "") .. "]"
	end,
	icon = icons.ui.Search,
	cond = function()
		return cmake.is_cmake_project() and not cmake.has_cmake_preset()
	end,
	on_click = function(n, mouse)
		if n == 1 then
			if mouse == "l" then
				vim.cmd("CMakeSelectBuildType")
			end
		end
	end,
})

ins_left({
	function()
		local kit = cmake.get_kit()
		return "[" .. (kit and kit or "X") .. "]"
	end,
	icon = icons.ui.Pencil,
	cond = function()
		return cmake.is_cmake_project() and not cmake.has_cmake_preset()
	end,
	on_click = function(n, mouse)
		if n == 1 then
			if mouse == "l" then
				vim.cmd("CMakeSelectKit")
			end
		end
	end,
})

ins_left({
	function()
		return "Build"
	end,
	icon = icons.ui.Gear,
	cond = cmake.is_cmake_project,
	on_click = function(n, mouse)
		if n == 1 then
			if mouse == "l" then
				vim.cmd("CMakeBuild")
			end
		end
	end,
})

ins_left({
	function()
		local b_preset = cmake.get_build_preset()
		return "[" .. (b_preset and b_preset or "X") .. "]"
	end,
	icon = icons.ui.Search,
	cond = function()
		return cmake.is_cmake_project() and cmake.has_cmake_preset()
	end,
	on_click = function(n, mouse)
		if n == 1 then
			if mouse == "l" then
				vim.cmd("CMakeSelectBuildPreset")
			end
		end
	end,
})

ins_left({
	function()
		local b_target = cmake.get_build_target()
		return "[" .. (b_target and b_target or "X") .. "]"
	end,
	cond = cmake.is_cmake_project,
	on_click = function(n, mouse)
		if n == 1 then
			if mouse == "l" then
				vim.cmd("CMakeSelectBuildTarget")
			end
		end
	end,
})

ins_left({
	function()
		return icons.ui.Debug
	end,
	cond = cmake.is_cmake_project,
	on_click = function(n, mouse)
		if n == 1 then
			if mouse == "l" then
				vim.cmd("CMakeDebug")
			end
		end
	end,
})

ins_left({
	function()
		return icons.ui.Run
	end,
	cond = cmake.is_cmake_project,
	on_click = function(n, mouse)
		if n == 1 then
			if mouse == "l" then
				vim.cmd("CMakeRun")
			end
		end
	end,
})

ins_left({
	function()
		local l_target = cmake.get_launch_target()
		return "[" .. (l_target and l_target or "X") .. "]"
	end,
	cond = cmake.is_cmake_project,
	on_click = function(n, mouse)
		if n == 1 then
			if mouse == "l" then
				vim.cmd("CMakeSelectLaunchTarget")
			end
		end
	end,
})
--

ins_right({
	-- Lsp server name .
	function()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		local buf_client_names = {}
		if next(clients) == nil then
			return msg
		end
		-- Write code that gets the names of attached clients and
		-- append to buf_client_names

		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			-- Check if attached client is null-ls then check the formatters and linters attached to it and print them
			if client.name == "null-ls" then
				-- print(client.name)
				local null_ls_sources_attached = {}
				for _, type in ipairs({ "FORMATTING", "DIAGNOSTICS" }) do
					for _, source in ipairs(null_ls_sources(buf_ft, type)) do
						table.insert(buf_client_names, source)
					end
				end
				-- vim.list_extend(buf_client_names, vim.tbl_keys(null_ls_sources_attached))
			end
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				table.insert(buf_client_names, client.name)
			end
		end
		if next(buf_client_names) == nil then
			return msg
		end

		-- Remove null-ls from the buf_client_names
		for i, v in ipairs(buf_client_names) do
			if v == "null-ls" then
				table.remove(buf_client_names, i)
			end
		end
		local str = table.concat(buf_client_names, ",")

		-- print the str table in lualine
		-- print(str)
		return str
	end,
	icon = " LSP:",
	color = {
		fg = "#ffffff",
		gui = "bold",
	},
	on_click = function(n, mouse)
		if n == 1 then
			if mouse == "l" then
				vim.cmd("LspInfo")
			end
		end
	end,
})

-- Add component to the right that check if Copilot is attached and displays it
ins_right({

	function()
		return require("copilot_status").status_string()
	end,
	cnd = function()
		return require("copilot_status").enabled()
	end,
	on_click = function(n, mouse)
		if n == 1 then
			if mouse == "l" then
				vim.cmd("Copilot status")
			end
		end
	end,
})

-- Add components to right sections
ins_right({
	"o:encoding",      -- option component same as &encoding in viml
	fmt = string.upper, -- I'm not sure why it's upper case either ;)
	cond = conditions.hide_in_width,
	color = {
		fg = colors.green,
		gui = "bold",
	},
})

-- ins_right {
--   'fileformat',
--   fmt = string.upper,
--   icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
--   color = { fg = colors.green, gui = 'bold' },
-- }

ins_right({
	"branch",
	icon = "",
	color = {
		fg = colors.violet,
		gui = "bold",
	},
	on_click = function(n, mouse)
		if n == 1 then
			if mouse == "l" then
				vim.cmd("Telescope git_branches")
			end
		end
	end,
})

ins_right({
	"diff",
	-- Is it me or the symbol for modified us really weird
	symbols = {
		added = " ",
		modified = "󰝤 ",
		removed = " ",
	},
	diff_color = {
		added = {
			fg = colors.green,
		},
		modified = {
			fg = colors.orange,
		},
		removed = {
			fg = colors.red,
		},
	},
	cond = conditions.hide_in_width,
	on_click = function(n, mouse)
		if n == 1 then
			if mouse == "l" then
				vim.cmd("Telescope git_status")
			end
		end
	end,
})

ins_right({
	function()
		return "▊"
	end,
	color = {
		fg = colors.blue,
	},
	padding = {
		left = 1,
	},
})

-- Now don't forget to initialize lualine
lualine.setup(config)
