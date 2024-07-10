return {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  opts = function(_, opts)
    opts.ensure_installed = { "vimdoc" }
    opts.auto_install = false
  end,
}
