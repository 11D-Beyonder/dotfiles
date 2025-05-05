return {
	{
		"neovim/nvim-lspconfig",
		cond = not vim.g.vscode,
		event = "BufRead",
		init = function()
			vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
			vim.fn.sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticSignHint" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
			vim.lsp.inlay_hint.enable()
		end,
		opts = {
			servers = {
				basedpyright = {
					settings = {
						basedpyright = {
							disableOrganizeImports = true,
							analysis = { typeCheckingMode = "off" },
						},
					},
				},
				bashls = {},
				clangd = {
					cmd = {
						"clangd",
						"--fallback-style=webkit",
						"--offset-encoding=utf-8",
						"--clang-tidy",
						"--completion-style=detailed",
						"--query-driver=C:\\Users\\joe\\scoop\\apps\\llvm-mingw\\current\\bin\\clang++.exe,C:\\Users\\joe\\scoop\\apps\\llvm-mingw\\current\\bin\\clang.exe",
					},
				},
				docker_compose_language_service = {},
				dockerls = {},
				lua_ls = {},
				neocmake = {},
				ruff = {},
				taplo = {},
			},
		},
		config = function(_, opts)
			local lspconfig = require "lspconfig"
			for server, config in pairs(opts.servers) do
				lspconfig[server].setup(vim.tbl_deep_extend("force", {
					capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities),
				}, config))
			end
		end,
	},
}
