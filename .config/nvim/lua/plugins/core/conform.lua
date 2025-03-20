return {
	"stevearc/conform.nvim",
	dependencies = "neovim/nvim-lspconfig",
	event = { "BufWritePre", "LspAttach" },
	cmd = "ConformInfo",
	cond = not vim.g.vscode,
	keys = {
		{
			"<leader>lf",
			function() require("conform").format { async = true } end,
			mode = { "n", "v" },
			desc = "[L]SP: [F]ormat",
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args) require("conform").format { bufnr = args.buf } end,
		})
	end,
	opts = {
		formatters_by_ft = {
			["yaml.docker-compose"] = { "prettierd", "prettier", stop_after_first = true },
			lua = { "stylua" },
			python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
			sh = { "shfmt" },
			yaml = { "prettierd", "prettier", stop_after_first = true },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = { timeout_ms = 500 },
	},
}
