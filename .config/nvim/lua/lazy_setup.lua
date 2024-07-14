require("lazy").setup({
  {
    "AstroNvim/AstroNvim",
    version = "^4",
    import = "astronvim.plugins",
    opts = {
      mapleader = " ",
      maplocalleader = ",",
      icons_enabled = true,
      pin_plugins = nil,
      update_notifications = true,
    },
  },
  { import = "plugins.core" },
  { import = "plugins.enhancements" },
  { import = "plugins.langpacks" },
  { import = "plugins.ui" },
}, {
  install = { colorscheme = { "bamboo" } },
  ui = { backdrop = 100 },
  performance = {
    rtp = {
      -- disable some rtp plugins, add more to your liking
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
})
