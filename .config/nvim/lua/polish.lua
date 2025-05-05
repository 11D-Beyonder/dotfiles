vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = false }),
	callback = function() vim.highlight.on_yank { timeout = 300 } end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("wrap_spell", { clear = false }),
	pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua", "html", "vue", "javascript", "typescript" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
	end,
})
vim.api.nvim_create_autocmd({ "DirChanged", "BufEnter" }, {
	callback = function()
		local is_cmake = vim.fn.filereadable "CMakeLists.txt" == 1
		local cmd = is_cmake and "<cmd>CMakeDebug<cr>" or "<cmd>DapContinue<cr>"
		local desc = is_cmake and "[D]ap: Run/[C]ontinue CMake Debug" or "[D]ap: Run/[C]ontinue"

		vim.keymap.set("n", "<F5>", cmd, { noremap = false, silent = true, desc = desc })
		vim.keymap.set("n", "<leader>dc", cmd, { noremap = false, silent = true, desc = desc })
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_keymap", { clear = false }),
	callback = function(args)
		local diagnostic_goto = function(next, severity)
			local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
			severity = severity and vim.diagnostic.severity[severity] or nil
			return function() go { severity = severity } end
		end
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.name == "ruff" then client.server_capabilities.hoverProvider = false end

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
	end,
})
