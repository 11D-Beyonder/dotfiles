vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 文档：https://neovim.io/doc/user/options.html

-- 控制是否在底部显示当前的模式（如插入模式、可视模式等）。
vim.opt.showmode = false
-- 控制退格键的行为。允许退格键删除缩进、行尾和插入模式下的起始位置。
vim.opt.backspace = { "indent", "eol", "start" }
-- 制表符为 4 空格。
vim.opt.tabstop = 4
-- 缩进命令 "<" 和 ">" 使用的宽度为 4 空格。
vim.opt.shiftwidth = 4
-- 制表符转为空格。
vim.opt.expandtab = false
-- 自动缩进
vim.opt.autoindent = true
-- 智能缩进
vim.opt.smartindent = true
-- 当使用 "<" 或 ">" 会将缩进自动调整到 shiftwidth 的宽度整数倍。
vim.opt.shiftround = true
-- 显示行号。
vim.opt.number = true
-- 显示相对行号。
vim.opt.relativenumber = true
vim.opt.ignorecase = true -- 搜索忽略大小写。
vim.opt.smartcase = true -- 如果搜索模式中包含大写，则区分大小写。
vim.opt.cursorline = true -- 高亮当前行。
vim.opt.termguicolors = true -- 启用真彩色支持。
vim.opt.signcolumn = "auto" -- 自动显示标记列用于显示调试、错误警告等图标。
vim.opt.autoread = true -- 外部文件被修改时自动重新加载。
vim.opt.swapfile = false -- 禁用交换文件。
vim.opt.backup = false -- 禁用备份文件。
vim.opt.updatetime = 50 -- 交换文件写入磁盘时间（毫秒）。
vim.opt.mouse = "a" -- 允许在普通模式、可视模式、插入模式使用鼠标。
vim.opt.undofile = true -- 启用持久撤销功能。
vim.opt.undolevels = 10000 -- 撤销历史最大 10000。
vim.opt.wrap = false -- 禁用折叠行。
vim.opt.splitbelow = true -- 水平分割窗口在下方打开。
vim.opt.splitright = true -- 垂直分割新窗口会在右侧打开。
vim.opt.completeopt = "menu,menuone,noselect" -- 永远显示补全菜单，不自动选择第一个匹配项。
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- 不是 SSH 连接的话就使用系统剪贴板。
vim.opt.confirm = true -- 退出修改缓冲区会弹出确认框。
vim.opt.timeoutlen = vim.g.vscode and 1000 or 300 -- 按键超时时间（毫秒）
vim.opt.virtualedit = "block" -- 可视模式下，允许光标移动到没有文本的区域。
vim.opt.wildmode = "longest:full,full" -- 命令行补全到最长公共前缀，显示所有匹配项。
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.opt.splitkeep = "screen"
vim.opt.updatetime = 200
vim.b.fileencoding = "utf-8"
