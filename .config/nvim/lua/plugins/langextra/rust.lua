return {
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false,
		init = function()
			vim.g.rustaceanvim = {
				tools = {},
				server = {
					on_attach = function(_, bufnr)
						vim.keymap.set("n", "<leader>LD", function() vim.cmd.RustLsp "debuggables" end, {
							silent = true,
							buffer = bufnr,
							desc = "rust-analyzer Configured [D]ebuggable Targets",
						})
						vim.keymap.set("n", "<leader>Ld", function() vim.cmd.RustLsp "debug" end, {
							silent = true,
							buffer = bufnr,
							desc = "[D]ebug Current Target Configured by rust-analyzer",
						})
						vim.keymap.set("n", "<leader>LR", function() vim.cmd.RustLsp "runnables" end, {
							silent = true,
							buffer = bufnr,
							desc = "select [R]unnable targets",
						})
						vim.keymap.set("n", "<leader>Lr", function() vim.cmd.RustLsp "run" end, {
							silent = true,
							buffer = bufnr,
							desc = "[R]un Current Target",
						})
						vim.keymap.set("n", "<leader>Lm", function() vim.cmd.RustLsp "expandMacro" end, {
							silent = true,
							buffer = bufnr,
							desc = "Expand [M]acro",
						})
						vim.keymap.set("n", "<leader>LM", function() vim.cmd.RustLsp "rebuildProcMacros" end, {
							silent = true,
							buffer = bufnr,
							desc = "Rebuild Proc [M]acros",
						})
						vim.keymap.set("n", "<leader>Lp", function() vim.cmd.RustLsp "parentModule" end, {
							silent = true,
							buffer = bufnr,
							desc = "[P]arent Module",
						})
					end,
				},
			}
		end,
	},
	{
		"saecki/crates.nvim",
		tag = "stable",
		event = { "BufRead Cargo.toml" },
		opts = {
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
			completion = {
				crates = { enabled = true },
			},
			on_attach = function(_, bufnr)
				vim.keymap.set(
					"n",
					"<leader>Lt",
					require("crates").toggle,
					{ silent = true, buffer = bufnr, desc = "[T]oggle UI Elements" }
				)
				vim.keymap.set(
					"n",
					"<leader>Lr",
					require("crates").reload,
					{ silent = true, buffer = bufnr, desc = "[R]eload Crates Information" }
				)
				vim.keymap.set(
					"n",
					"<leader>Lv",
					require("crates").show_versions_popup,
					{ silent = true, buffer = bufnr, desc = "[V]ersions Popup" }
				)

				vim.keymap.set(
					"n",
					"<leader>Lf",
					require("crates").show_features_popup,
					{ silent = true, buffer = bufnr, desc = "[F]eatures Popup" }
				)
				vim.keymap.set(
					"n",
					"<leader>Ld",
					require("crates").show_dependencies_popup,
					{ silent = true, buffer = bufnr, desc = "[D]ependencies Popup" }
				)
				vim.keymap.set(
					"n",
					"<leader>Lu",
					require("crates").update_crate,
					{ silent = true, buffer = bufnr, desc = "[U]pdate Current Crate" }
				)
				vim.keymap.set(
					"v",
					"<leader>Lu",
					require("crates").update_crates,
					{ silent = true, buffer = bufnr, desc = "[U]pdate Crates in Range" }
				)
				vim.keymap.set(
					"n",
					"<leader>LU",
					require("crates").update_all_crates,
					{ silent = true, buffer = bufnr, desc = "[U]pdate All Crates" }
				)
				vim.keymap.set(
					"n",
					"<leader>Le",
					require("crates").expand_plain_crate_to_inline_table,
					{ silent = true, buffer = bufnr, desc = "[E]xpand Plain Crate to Inline Table" }
				)
				vim.keymap.set(
					"n",
					"<leader>LE",
					require("crates").extract_crate_into_table,
					{ silent = true, buffer = bufnr, desc = "[E]xtract Crate into Table" }
				)
				vim.keymap.set(
					"n",
					"<leader>Lh",
					require("crates").open_homepage,
					{ silent = true, buffer = bufnr, desc = "Open Crate [H]omepage" }
				)
				vim.keymap.set(
					"n",
					"<leader>LR",
					require("crates").open_repository,
					{ silent = true, buffer = bufnr, desc = "Open Crate [R]epository" }
				)
				vim.keymap.set(
					"n",
					"<leader>LD",
					require("crates").open_documentation,
					{ silent = true, buffer = bufnr, desc = "Open Crate [D]ocumentation" }
				)
				vim.keymap.set(
					"n",
					"<leader>Lc",
					require("crates").open_crates_io,
					{ silent = true, buffer = bufnr, desc = "Open in [c]rates.io" }
				)
				vim.keymap.set(
					"n",
					"<leader>Ll",
					require("crates").open_lib_rs,
					{ silent = true, buffer = bufnr, desc = "Open in [l]ib.rs" }
				)
			end,
		},
	},
}
