return {
	"folke/lazydev.nvim",
	ft = "lua", -- only load on lua files
	cond = not vim.g.vscode,
	opts = {
		library = {
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
		integrations = {
			cmp = false,
			coq = false,
		},
	},
}
