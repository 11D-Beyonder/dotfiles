return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "BufRead",
	init = function() vim.opt.termguicolors = true end,
	dependencies = {
		"catppuccin/nvim",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>x", function() Snacks.bufdelete() end, desc = "Delete Current Buffer" },
		{ "<leader>X", "<cmd>BufferLineCloseOthers<cr>", desc = "Delete Others Buffers" },
		{ "<leader>bd", "<cmd>BufferLinePickClose<cr>", desc = "[B]ufferLine: [D]elete Buffers with Picker" },
		{ "<leader>bs", "<cmd>BufferLinePick<cr>", desc = "[B]ufferLine: [S]elect Buffers" },
		{ "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "[B]ufferLine: Toggle [P]in" },
		{ "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", desc = "[B]ufferLine: Delete Non-[P]inned Buffers" },
		{ "<leader>br", "<cmd>BufferLineCloseRight<CR>", desc = "[B]ufferLine: Delete to the [R]ight" },
		{ "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", desc = "[B]ufferLine: Delete to the [L]eft" },
		{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "[B]ufferLine: (Previous) [B]uffer" },
		{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "[B]ufferLine: (Next) [B]uffer" },
		{ "[B", "<cmd>BufferLineMovePrev<cr>", desc = "[B]ufferLine: Move [B]uffer (Forward)" },
		{ "]B", "<cmd>BufferLineMoveNext<cr>", desc = "[B]ufferLine: Move [B]uffer (Backwards)" },
		{ "]t", function() vim.cmd.tabnext() end, desc = "[B]ufferLine: (Next) [T]ab" },
		{ "[t", function() vim.cmd.tabprevious() end, desc = "[B]ufferLine: (Previous) [T]ab" },
	},
	opts = {
		options = {
			close_command = function(n) Snacks.bufdelete(n) end,
			right_mouse_command = function(n) Snacks.bufdelete(n) end,
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(_, _, diag)
				local icons = { Error = " ", Warn = " ", Hint = " ", Info = " " }
				local res = (diag.error and icons.Error .. diag.error .. " " or "")
					.. (diag.warning and icons.Warn .. diag.warning or "")
				return vim.trim(res)
			end,
		},
	},
	config = function(_, opts)
		opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
		require("bufferline").setup(opts)
	end,
}
