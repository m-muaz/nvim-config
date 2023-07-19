if vim.fn.executable("cmake-language-server") == 1 then
	require("lspconfig").cmake.setup({
		cmd = { "cmake-language-server" },
		root_dir = function()
			return vim.fn.getcwd()
		end,
		whitelist = { "cmake" },
		init_options = {
			buildDirectory = "build",
		},
	})
end

if vim.fn.executable("ltex-ls") == 1 then
	require("lspconfig").ltex.setup({
		cmd = { "ltex-ls" },
		filetypes = { "tex" },
		root_dir = require("lspconfig").util.root_pattern(".git", "."),
		-- root_dir = function()
		-- 	return vim.fn.getcwd()
		-- end,
		settings = {
			ltex = {
				enabled = { "latex", "tex", "bib", "plaintex" },
				language = "en",
				diagnostics = {
					enabled = true,
					suggestions = true,
					underline = true,
				},
				formatterLineLength = 80,
				forwardSearch = {
					executable = "skim",
					args = { "--forward-search", "%p", "%l" },
					onSave = false,
				},
				-- bibtexFormatter = "texlab",
				latexFormatter = "latexindent",
			},
		},
	})
end
