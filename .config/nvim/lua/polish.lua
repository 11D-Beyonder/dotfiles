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
