local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new { cmd = "lazygit", hidden = true, direction = "float" }

function _lazygit_toggle() lazygit:toggle() end
return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = { "Toggleterm", "TermSelect" },
	opts = {
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
		open_mapping = [[<c-\>]],
	},
	keys = {
		{ "<leader>tg", "<cmd>lua _lazygit_toggle()<cr>", desc = "Toggle Lazygit" },
	},
}
