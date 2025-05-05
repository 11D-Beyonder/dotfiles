return {
	"nvim-treesitter/nvim-treesitter",
	cond = not vim.g.vscode,
	event = "BufRead",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		{
			"Joakker/lua-json5",
			run = function()
				if vim.fn.has "win32" == 1 then
					return "powershell ./install.ps1"
				else
					return "./install.sh"
				end
			end,
		},
	},
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"cmake",
			"cpp",
			"dockerfile",
			"html",
			"json5",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"regex",
			"rust",
			"toml",
		},
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
					["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
				},
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
				include_surrounding_whitespace = false,
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.install").prefer_git = false
		require("nvim-treesitter.configs").setup(opts)
	end,
}
