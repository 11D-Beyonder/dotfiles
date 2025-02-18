return {
	"echasnovski/mini.files",
	keys = {
		{
			"<leader>e",
			"<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr><cmd>lua MiniFiles.reveal_cwd()<cr>",
			desc = "Open Mini File [E]xplorer",
		},
	},
	config = true,
}
