return {
  "AstroNvim/astrocore",
  optional = true,
  opts = {
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 },
      autopairs = true,
      cmp = true,
      diagnostics_mode = 3,
      highlighturl = true,
      notifications = true,
    },
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "yes",
        wrap = true,
        tabstop = 4,
        shiftwidth = 0,
        cursorlineopt = "both",
        termguicolors = true,
      },
    },
    mappings = {
      n = {
        ["<leader>y"] = {
          function() vim.cmd "%y+" end,
          desc = "File copy whole",
        },
      },
    },
  },
}
