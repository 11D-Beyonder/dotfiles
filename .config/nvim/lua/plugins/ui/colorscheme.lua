return {
	{
		"catppuccin/nvim",
		lazy = false,
		cond = not vim.g.vscode,
		priority = 1000,
		name = "catppuccin",
		opts = {
			term_colors = true,
			integrations = {
				blink_cmp = true,
				dap = true,
				dap_ui = true,
				dropbar = {
					enabled = true,
					color_mode = true, -- enable color for kind's texts, not just kind's icons
				},
				flash = true,
				fzf = true,
				mason = true,
				noice = true,
				notify = true,
				snacks = true,
				treesitter = true,
				which_key = true,
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd [[colorscheme catppuccin-latte]]
		end,
	},
}
