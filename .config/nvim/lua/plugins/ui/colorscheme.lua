return {
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    config = function(_, opts) require("bamboo").setup(opts) end,
  },
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    opts = {
      filter = "classic",
    },
    config = function(_, opts)
      require("monokai-pro").setup(opts)
      vim.cmd "colorscheme monokai-pro"
    end,
  },
}
