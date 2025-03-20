return {
	"saghen/blink.cmp",
	event = { "VimEnter", "InsertEnter" },
	dependencies = {
		"rafamadriz/friendly-snippets",
		{
			"saghen/blink.compat",
			version = "*",
			lazy = true,
			opts = {},
		},
	},
	version = "*",
	cond = not vim.g.vscode,
	opts = {
		keymap = {
			preset = "enter",
			["<c-k>"] = { "select_prev", "fallback" },
			["<c-j>"] = { "select_next", "fallback" },
			["<c-a-k>"] = { "scroll_documentation_up", "fallback" },
			["<c-a-j>"] = { "scroll_documentation_down", "fallback" },
		},
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 100,
			},
			ghost_text = {
				enabled = false,
			},
		},
		sources = {
			default = {
				"lazydev",
				"lsp",
				"path",
				"snippets",
				"buffer",
				"avante_commands",
				"avante_mentions",
				"avante_files",
			},
			providers = {
				avante_commands = {
					name = "avante_commands",
					module = "blink.compat.source",
					score_offset = 90, -- show at a higher priority than lsp
					opts = {},
				},
				avante_files = {
					name = "avante_files",
					module = "blink.compat.source",
					score_offset = 100, -- show at a higher priority than lsp
					opts = {},
				},
				avante_mentions = {
					name = "avante_mentions",
					module = "blink.compat.source",
					score_offset = 1000, -- show at a higher priority than lsp
					opts = {},
				},
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
			},
		},
	},
	opts_extend = { "sources.default" },
}
