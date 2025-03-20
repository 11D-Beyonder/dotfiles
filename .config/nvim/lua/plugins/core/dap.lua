return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
		},
		cond = not vim.g.vscode,
		cmd = "DapContinue",
		init = function()
			vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
			vim.fn.sign_define(
				"DapStopped",
				{ text = "󰁕 ", texthl = "DiagnosticWarn", linehl = "DapStoppedLine", numhl = "DapStoppedLine" }
			)
			vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticInfo" })
			vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "DiagnosticInfo" })
			vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DiagnosticError" })
			vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "DiagnosticInfo" })
		end,
		keys = {
			{
				"<leader>dB",
				function() require("dap").set_breakpoint(vim.fn.input "Breakpoint Condition: ") end,
				desc = "Conditional [B]reakpoint",
			},
			{
				"<leader>db",
				function() require("dap").toggle_breakpoint() end,
				desc = "Toggle [B]reakpoint",
			},
			{
				"<F9>",
				function() require("dap").toggle_breakpoint() end,
				desc = "Toggle [B]reakpoint",
			},
			{
				"<F5>",
				"<cmd>DapContinue<cr>",
				desc = "Run/[C]ontinue",
			},
			{
				"<leader>dc",
				"<cmd>DapContinue<cr>",
				desc = "Run/[C]ontinue",
			},
			{
				"<leader>dC",
				function() require("dap").run_to_cursor() end,
				desc = "Run to [C]ursor",
			},
			{
				"<leader>dg",
				function() require("dap").goto_() end,
				desc = "[G]o to Line (No Execute)",
			},
			{
				"<leader>di",
				function() require("dap").step_into() end,
				desc = "Step [I]nto",
			},
			{
				"<F11>",
				function() require("dap").step_into() end,
				desc = "Step [I]nto",
			},
			{
				"<leader>dj",
				function() require("dap").down() end,
				desc = "Down",
			},
			{
				"<leader>dk",
				function() require("dap").up() end,
				desc = "Up",
			},
			{
				"<leader>dl",
				function() require("dap").run_last() end,
				desc = "Run [L]ast",
			},
			{
				"<leader>do",
				function() require("dap").step_out() end,
				desc = "Step [O]ut",
			},
			{
				"<F12>",
				function() require("dap").step_out() end,
				desc = "Step [O]ut",
			},
			{
				"<leader>dO",
				function() require("dap").step_over() end,
				desc = "Step [O]ver",
			},
			{
				"<F10>",
				function() require("dap").step_over() end,
				desc = "Step [O]ver",
			},
			{
				"<leader>dp",
				function() require("dap").pause() end,
				desc = "[P]ause",
			},
			{
				"<leader>dr",
				function() require("dap").repl.toggle() end,
				desc = "Toggle [R]EPL",
			},
			{
				"<leader>ds",
				function() require("dap").session() end,
				desc = "[S]ession",
			},
			{
				"<leader>dt",
				function() require("dap").terminate() end,
				desc = "[T]erminate",
			},
		},
		config = function()
			local dap = require "dap"
			-- dap.set_log_level("TRACE")
			-- dap.adapters.lldb = {
			-- 	type = "executable",
			-- 	command = "codelldb" .. (vim.fn.has("win32") == 1 and ".cmd" or ""),
			-- 	detached = (vim.fn.has("win32") == 0),
			-- }
			dap.adapters.lldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = "codelldb" .. (vim.fn.has "win32" == 1 and ".cmd" or ""),
					args = { "--port", "${port}" },
					detached = vim.fn.has "win32" == 0,
				},
			}
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		keys = {
			{ "<leader>du", function() require("dapui").toggle() end, desc = "Dap UI" },
			{ "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" } },
		},
		opts = {},
		config = function(_, opts)
			local dap = require "dap"
			local dapui = require "dapui"
			dapui.setup(opts)
			dap.listeners.before.attach.dapui_config = function() dapui.open() end
			dap.listeners.before.launch.dapui_config = function() dapui.open() end
		end,
	},
}
