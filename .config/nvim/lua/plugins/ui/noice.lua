return {
  "folke/noice.nvim",
  opts = {
    lsp = {
      hover = { enabled = false },
      signature = { enabled = false },
      progress = { enabled = false },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = false,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = false,
    },
    popupmenu = {
      enabled = false,
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
    {
      "nvim-treesitter/nvim-treesitter",
      optional = true,
      opts = function(_, opts)
        if opts.ensure_installed ~= "all" then
          opts.ensure_installed = require("astrocore").list_insert_unique(
            opts.ensure_installed,
            { "vim", "regex", "lua", "bash", "markdown", "markdown_inline" }
          )
        end
      end,
    },
  },
}
