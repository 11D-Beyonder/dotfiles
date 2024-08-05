return {
  "APZelos/blamer.nvim",
  lazy = false,
  cond = vim.fn.finddir(".git", vim.fn.getcwd() .. ";") ~= "",
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      options = {
        g = {
          blamer_enabled = true,
          blamer_show_in_insert_modes = true,
          blamer_delay = 0,
          blamer_date_format = "%Y年%m月%d日",
        },
      },
    },
  },
}
