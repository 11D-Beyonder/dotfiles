return {
	"Bekaboo/dropbar.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = "BufRead",
	opts = {
		bar = {
			sources = function(buf, _)
				local sources = require "dropbar.sources"
				local utils = require "dropbar.utils"
				if vim.bo[buf].ft == "markdown" then
					return {
						sources.path,
						sources.markdown,
					}
				elseif vim.bo[buf].buftype == "terminal" then
					return {
						sources.terminal,
					}
				else
					return {
						utils.source.fallback {
							sources.lsp,
							sources.treesitter,
						},
					}
				end
			end,
		},
	},
	config = function(_, opts)
		require("dropbar").setup(opts)
		local dropbar_api = require "dropbar.api"
		vim.keymap.set("n", "<leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
		vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
		vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
	end,
}
