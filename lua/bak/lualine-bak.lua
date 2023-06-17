 local status_ok, lualine = pcall(require, "lualine")
 if not status_ok then
 	return
 end

 -- Color table for highlights
 -- stylua: ignore
 local colors = {
   bg       = '#202328',
   fg       = '#bbc2cf',
   yellow   = '#ECBE7B',
   cyan     = '#008080',
   darkblue = '#081633',
   green    = '#98be65',
   orange   = '#FF8800',
   violet   = '#a9a1e1',
   magenta  = '#c678dd',
   blue     = '#51afef',
   red      = '#ec5f67',
 }

 local hide_in_width = function()
 	return vim.fn.winwidth(0) > 80
 end

 local diagnostics = {
 	"diagnostics",
 	sources = { "nvim_diagnostic" },
 	sections = { "error", "warn" },
 	symbols = { error = " ", warn = " " },
 	colored = false,
 	update_in_insert = true,
 	always_visible = true,
 }

 local diff = {
 	"diff",
 	colored = false,
 	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
   cond = hide_in_width
 }

 local mode = {
 	"mode",
 	fmt = function(str)
 		return "-- " .. str .. " --"
 	end,
 }

 local filetype = {
 	"filetype",
 	icons_enabled = true,
 	icon = nil,
 }

 local branch = {
 	"branch",
 	icons_enabled = true,
 	icon = "",
 }

 local location = {
 	"location",
 	padding = 0,
 }

   -- Lsp server name .
  local LSP =   function()
     local msg = 'No Active Lsp'
     local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
     local clients = vim.lsp.get_active_clients()
     if next(clients) == nil then
       return msg
     end
     for _, client in ipairs(clients) do
       local filetypes = client.config.filetypes
       if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
         return client.name
       end
     end
     return msg
   end


 -- cool function for progress
 local progress = function()
 	local current_line = vim.fn.line(".")
 	local total_lines = vim.fn.line("$")
 	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
 	local line_ratio = current_line / total_lines
 	local index = math.ceil(line_ratio * #chars)
 	return chars[index]
 end

 local spaces = function()
 	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
 end

 lualine.setup({
 	options = {
 		icons_enabled = true,
 		theme = "auto",
 		component_separators = { left = "", right = "" },
 		section_separators = { left = "", right = "" },
 		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
 		always_divide_middle = true,
 	},
 	sections = {
 		lualine_a = { branch, diagnostics },
 		lualine_b = { mode },
 		lualine_c = {},
 		-- lualine_x = { "encoding", "fileformat", "filetype" },
 		lualine_x = {LSP, diff, spaces, "encoding", filetype },
 		lualine_y = { location },
 		lualine_z = { progress },
 	},
   highlights = {
       LspIcon = {
         guifg = "#FFCC00", -- set the icon color
         gui = "bold", -- set the icon style (e.g., bold)
       },
   },
     inactive_sections = {
 		lualine_a = {},
 		lualine_b = {},
 		lualine_c = { "filename" },
 		lualine_x = { "location" },
 		lualine_y = {},
 		lualine_z = {},
 	},
 	tabline = {},
 	extensions = {},
 })



