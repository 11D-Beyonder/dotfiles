return {
	"ibhagwan/fzf-lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	cmd = "FzfLua",
	cond = not vim.g.vscode,
	opts = {},
	keys = {
		{ "<leader>ff", "<cmd>FzfLua files<cr>", mode = "n", desc = "[F]zfLua: Find [F]iles" },
		{ "<leader>fh", "<cmd>FzfLua helptags<cr>", mode = "n", desc = "[F]zfLua: Find Helptags" },
		{ "<leader>fg", "<cmd>FzfLua live_grep_native<cr>", mode = "n", desc = "[F]zfLua: Live [G]rep in CWD" },
		{ "<leader>f/", "<cmd>FzfLua lgrep_curbuf<cr>", mode = "n", desc = "[F]zfLua: Live [G]rep in Current Buffer" },
		{ "<leader>fv", "<cmd>FzfLua grep_visual<cr>", mode = "v", desc = "[F]zfLua: Grep [V]isual" },
		{ "<leader>fn", "<cmd>NoiceFzf<cr>", mode = "n", desc = "[F]zfLua: Find [N]otifications" },
		{ "<leader>fb", "<cmd>FzfLua buffers<cr>", mode = "n", desc = "[F]zfLua: Find [B]uffers" },
	},
	config = function(_, opts)
		require("fzf-lua").setup(opts)
		require("fzf-lua").register_ui_select()
	end,
}
