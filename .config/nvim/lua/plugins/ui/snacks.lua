return {
	"folke/snacks.nvim",
	cond = not vim.g.vscode,
	lazy = false,
	opts = {
		bufdelete = { enabled = true },
		indent = {
			enabled = true,
		},
		dashboard = {
			enabled = true,
		},
		input = { enabled = true },
		notify = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
}
