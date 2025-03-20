return {
	"luozhiya/fittencode.nvim",
	cond = not vim.g.vscode,
	opts = {
		source_completion = {
			engine = "blink",
		},
	},
}
