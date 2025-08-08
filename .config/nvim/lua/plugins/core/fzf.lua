return {
	"ibhagwan/fzf-lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	cmd = "FzfLua",
	cond = not vim.g.vscode,
	opts = {},
	keys = {
		{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "[F]zfLua: Find [F]iles" },
		{ "<leader>fh", "<cmd>FzfLua helptags<cr>", desc = "[F]zfLua: Find Helptags" },
		{ "<leader>fg", "<cmd>FzfLua live_grep_native<cr>", desc = "[F]zfLua: Live [G]rep in CWD" },
		{ "<leader>f/", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "[F]zfLua: Live [G]rep in Current Buffer" },
		{ "<leader>fv", "<cmd>FzfLua grep_visual<cr>", mode = "v", desc = "[F]zfLua: Grep [V]isual" },
		{ "<leader>fn", "<cmd>NoiceFzf<cr>", desc = "[F]zfLua: Find [N]otifications" },
		{ "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "[F]zfLua: Find [B]uffers" },
		{ "<leader>ft", "<cmd>TermSelect<cr>", desc = "[F]zfLua: Find [T]erminals" },
	},
	config = function(_, opts)
		require("fzf-lua").setup(opts)
		require("fzf-lua").register_ui_select()
	end,
}
