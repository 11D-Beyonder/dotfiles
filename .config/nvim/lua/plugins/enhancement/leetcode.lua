return {
	"kawre/leetcode.nvim",
	cond = not vim.g.vscode,
	event = "VimEnter",
	dependencies = {
		"ibhagwan/fzf-lua",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		cn = {
			enabled = true,
		},
		injector = {
			["python3"] = {
				before = true,
			},
			["cpp"] = {
				before = {
					"#include<iostream>",
					"#include<algorithm>",
					"#include<queue>",
					"#include<stack>",
					"#include<string>",
					"#include<vector>",
					"using namespace std;",
				},
				after = "int main() {}",
			},
			["java"] = {
				before = "import java.util.*;",
			},
		},
	},
}
