return {
	"CRAG666/code_runner.nvim",
	cmd = { "RunCode", "RunFile", "RunProject" },
	opts = {
		mode = "toggleterm",
		filetype = {
			cpp = {
				"cd $dir &&",
				"clang++ $fileName -g -o",
				"$fileNameWithoutExt &&",
				"./$fileNameWithoutExt",
			},
		},
	},
}
