return {
	"nvim-lualine/lualine.nvim",
	cond = not vim.g.vscode,
	event = "BufEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "catppuccin-latte",
		},
		sections = {
			lualine_x = { "overseer" },
		},
	},
}
