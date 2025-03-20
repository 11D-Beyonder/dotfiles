return {
	"stevearc/overseer.nvim",
	cond = not vim.g.vscode,
	keys = {
		{ "<leader>ot", "<cmd>OverseerToggle right<cr>", desc = "[O]verseer: [T]oggle" },
		{ "<leader>or", "<cmd>OverseerRun<cr>", desc = "[O]verseer: [R]un Templates" },
	},
	opts = {},
}
