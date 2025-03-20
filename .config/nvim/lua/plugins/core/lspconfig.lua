local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function() go { severity = severity } end
end
local on_attach = function(client, bufnr)
	vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "[L]SP: [L]ine [D]iagnostics" })
	vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "(Next) [D]iagnostic" })
	vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "(Previous) [D]iagnostic" })
	vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "(Next) [E]rror" })
	vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "(Previous) [E]rror" })
	vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "(Next) [W]arning" })
	vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "(Previous) [W]arning" })
	vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references<cr>", { buffer = bufnr, desc = "[G]oto [R]ferences" })
	vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", { buffer = bufnr, desc = "[G]oto [D]efinitions" })
	vim.keymap.set("n", "gI", "<cmd>FzfLua lsp_implementations<cr>", { buffer = bufnr, desc = "[G]oto [D]efinitions" })
	vim.keymap.set("n", "gD", "<cmd>FzfLua lsp_declarations<cr>", { buffer = bufnr, desc = "[G]oto [D]eclarations" })
	vim.keymap.set("n", "gh", vim.lsp.buf.hover, { buffer = bufnr, desc = "[G]oto [H]over" })
	vim.keymap.set("n", "<leader>lr", ":IncRename ", { buffer = bufnr, desc = "[L]SP [R]ename" })
	vim.keymap.set(
		"n",
		"<leader>lR",
		function() return ":IncRename " .. vim.fn.expand "<cword>" end,
		{ buffer = bufnr, desc = "[L]SP [R]ename (prefill)", expr = true }
	)
	vim.keymap.set(
		"n",
		"<leader>la",
		"<cmd>FzfLua lsp_code_actions<cr>",
		{ buffer = bufnr, desc = "[L]SP: Code [A]ction" }
	)
	if client.name == "ruff" then client.server_capabilities.hoverProvider = false end
end

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
			},
		},
		config = function(_, opts)
			local lspconfig = require "lspconfig"
			for server, config in pairs(opts.servers) do
				lspconfig[server].setup(vim.tbl_deep_extend("force", {
					on_attach = on_attach,
					capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities),
				}, config))
			end
		end,
	},
}
