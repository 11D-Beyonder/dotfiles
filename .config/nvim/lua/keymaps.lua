vim.keymap.set("n", "<leader>w", "<cmd>w<cr><esc>", { desc = "Save Current Buffer" })
vim.keymap.set("n", "<leader>W", "<cmd>wall<cr><esc>", { desc = "Save All Buffers" })
vim.keymap.set("n", "<leader>q", "<cmd>confirm q<cr>", { desc = "Quit Current Window" })
vim.keymap.set("n", "<leader>Q", "<cmd>confirm qall<cr>", { desc = "Quit All Windows" })
vim.keymap.set("n", "<leader>y", "<cmd>%y+<cr>", { desc = "Copy Whole File" })
vim.keymap.set("n", "<leader>c", "<cmd>%d+<cr>cc", { desc = "Change Whole File" })
vim.keymap.set("n", "<esc>", "<cmd>nohl<cr>", { desc = "Extnguish Search Highlight" })

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
