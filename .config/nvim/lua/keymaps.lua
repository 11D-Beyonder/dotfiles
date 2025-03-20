if vim.g.vscode then
	vim.keymap.set("n", "<leader>q", function() require("vscode").action "workbench.action.closeWindow" end)
	vim.keymap.set("n", "<leader>w", function() require("vscode").action "workbench.action.files.save" end)

	vim.keymap.set("n", "|", function() require("vscode").action "workbench.action.splitEditor" end)
	vim.keymap.set("n", "_", function() require("vscode").action "workbench.action.splitEditorDown" end)

	vim.keymap.set("n", "<c-h>", function() require("vscode").action "workbench.action.navigateLeft" end)
	vim.keymap.set("n", "<c-l>", function() require("vscode").action "workbench.action.navigateRight" end)
	vim.keymap.set("n", "<c-j>", function() require("vscode").action "workbench.action.navigateDown" end)
	vim.keymap.set("n", "<c-k>", function() require("vscode").action "workbench.action.navigateUp" end)

	vim.keymap.set("n", "<c-\\>", function() require("vscode").action "workbench.action.terminal.toggleTerminal" end)

	vim.keymap.set("n", "]d", function() require("vscode").action "editor.action.marker.nextInFiles" end)
	vim.keymap.set("n", "[d", function() require("vscode").action "editor.action.marker.prevInFiles" end)

	vim.keymap.set(
		"v",
		"<leader>fg",
		function() require("vscode").action("workbench.action.findInFiles", { args = { query = vim.fn.expand "<cword>" } }) end
	)
	vim.keymap.set("n", "<leader>fg", function() require("vscode").action "workbench.action.findInFiles" end)
	vim.keymap.set("n", "<leader>ff", function() require("vscode").action "workbench.action.quickOpen" end)
	vim.keymap.set("n", "<leader>fn", function() require("vscode").action "notifications.showList" end)

	vim.keymap.set("n", "gh", function() require("vscode").action "editor.action.showHover" end)
	vim.keymap.set("n", "gI", function() require("vscode").action "editor.action.goToImplementation" end)
	vim.keymap.set("n", "gd", function() require("vscode").action "editor.action.revealDefinition" end)
	vim.keymap.set("n", "gD", function() require("vscode").action "editor.action.revealDeclaration" end)
	vim.keymap.set("n", "gr", function() require("vscode").action "editor.action.goToReference" end)
	vim.keymap.set("n", "gt", function() require("vscode").action "editor.action.goToTypeDefinition" end)
	vim.keymap.set("n", "gs", function() require("vscode").action "workbench.action.gotoSymbol" end)

	vim.keymap.set("n", "<leader>la", function() require("vscode").action "editor.action.quickFix" end)
	vim.keymap.set("n", "<leader>ls", function() require("vscode").action "workbench.action.showAllSymbols" end)
	vim.keymap.set("n", "<leader>lr", function() require("vscode").action "editor.action.rename" end)
	vim.keymap.set("n", "<leader>lf", function() require("vscode").action "editor.action.formatDocument" end)
else
	vim.keymap.set("n", "<leader>w", "<cmd>w<cr><esc>", { desc = "Save Current Buffer" })
	vim.keymap.set("n", "<leader>W", "<cmd>wall<cr><esc>", { desc = "Save All Buffers" })
	vim.keymap.set("n", "<leader>q", "<cmd>confirm q<cr>", { desc = "Quit Current Window" })
	vim.keymap.set("n", "<leader>Q", "<cmd>confirm qall<cr>", { desc = "Quit All Windows" })

	vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "Go to Left Window", remap = true })
	vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "Go to Lower Window", remap = true })
	vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "Go to Upper Window", remap = true })
	vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "Go to Right Window", remap = true })

	vim.keymap.set("n", "|", "<c-w>v", { desc = "Vertical Split" })
	vim.keymap.set("n", "_", "<c-w>c", { desc = "Horizen Split" })

	vim.keymap.set("n", "<c-up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
	vim.keymap.set("n", "<c-down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
	vim.keymap.set("n", "<c-left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
	vim.keymap.set("n", "<c-right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

	vim.keymap.set("n", "<leader>pi", "<cmd>Lazy install<cr>", { desc = "[P]ackage: [P]lugins Install" })
	vim.keymap.set("n", "<leader>pu", "<cmd>Lazy update<cr>", { desc = "[P]ackage: [U]pdate Lazy Plugins" })
end
vim.keymap.set("n", "<leader>y", "<cmd>%y+<cr>", { desc = "Copy Whole File" })
vim.keymap.set("n", "<leader>c", "<cmd>%d+<cr>cc", { desc = "Change Whole File" })
vim.keymap.set("n", "<esc>", "<cmd>nohl<cr>", { desc = "Extnguish Search Highlight" })
