return {
	{
		"Civitasv/cmake-tools.nvim",
		cond = not vim.g.vscode,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/overseer.nvim",
		},
		cmd = { "CMakeRun", "CMakeDebug", "CMakeQuickStart" },
		ft = { "c", "cmake", "cpp" },
		opts = {
			cmake_build_directory = vim.fn.has "win32" == 1 and "build\\${variant:buildType}" or "build/${variant:buildType}",
			cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE" },
			cmake_executor = { name = "overseer", opts = {} },
			cmake_runner = { name = "overseer", opts = {} },
			cmake_dap_configuration = {
				name = "cpp",
				type = "lldb",
				request = "launch",
				stopOnEntry = false,
				runInTerminal = true,
				console = "integratedTerminal",
			},
			cmake_notifications = {
				runner = { enabled = false },
				executor = { enabled = false },
			},
		},
	},
}
