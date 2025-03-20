local function term_nav(dir)
	return function(self)
		return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function() vim.cmd.wincmd(dir) end)
	end
end
return {
	"folke/snacks.nvim",
	cond = not vim.g.vscode,
	lazy = false,
	opts = {
		bufdelete = { enabled = true },
		indent = {
			enabled = true,
		},
		dashboard = {
			enabled = true,
		},
		input = { enabled = true },
		notify = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		terminal = {
			enabled = true,
			win = {
				keys = {
					nav_h = { "<c-h>", term_nav "h", desc = "Go to Left Window", expr = true, mode = "t" },
					nav_j = { "<c-j>", term_nav "j", desc = "Go to Lower Window", expr = true, mode = "t" },
					nav_k = { "<c-k>", term_nav "k", desc = "Go to Upper Window", expr = true, mode = "t" },
					nav_l = { "<c-l>", term_nav "l", desc = "Go to Right Window", expr = true, mode = "t" },
				},
			},
		},
		words = { enabled = true },
	},
	keys = {
		{ "<c-\\>", function() Snacks.terminal.toggle() end, mode = { "n", "t" }, desc = "Toggle Terminal" },
		{ "<c-s-\\>", function() Snacks.terminal.open() end, mode = { "n", "t" }, desc = "Toggle Terminal" },
	},
}
