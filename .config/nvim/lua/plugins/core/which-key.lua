return {
	"folke/which-key.nvim",
	cond = not vim.g.vscode,
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		preset = "helix",
	},
	keys = {
		{
			"<leader>?",
			function() require("which-key").show { global = false } end,
			desc = "Show Keymaps",
		},
	},
}
