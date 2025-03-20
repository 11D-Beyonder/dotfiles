return {
	"smjonas/inc-rename.nvim",
	cond = not vim.g.vscode,
	dependencies = "folke/noice.nvim",
	cmd = "IncRename",
	event = "LspAttach",
	config = true,
}
