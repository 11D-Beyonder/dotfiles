return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		cond = not vim.g.vscode,
		keys = {
			{ "<leader>pm", "<cmd>Mason<cr>", desc = "[P]ackage: Mason" },
		},
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
				keymaps = {
					toggle_help = "?",
				},
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = "williamboman/mason.nvim",
		cond = not vim.g.vscode,
		opts = {
			ensure_installed = {
				-- LSP
				"basedpyright",
				"bash-language-server",
				"clangd",
				"docker-compose-language-service",
				"dockerfile-language-server",
				"lua-language-server",
				"neocmakelsp",
				"ruff",
				"rust-analyzer",
				"taplo",
				-- DAP
				"codelldb",
				-- Linter
				-- Formatter
				"shfmt",
				"stylua",
			},
		},
	},
}
