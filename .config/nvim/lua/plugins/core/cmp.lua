local cmp = require "cmp"
return {
  "hrsh7th/nvim-cmp",
  optional = true,
  keys = { ":", "/", "?" },
  dependencies = {
    "hrsh7th/cmp-cmdline",
    config = function()
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
    end,
  },
  opts = {
    completion = {
      completeopt = "menuone,noinsert,noselect",
    },
  },
}
