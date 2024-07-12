local cmp = require "cmp"
local luasnip = require "luasnip"
return {
  "hrsh7th/nvim-cmp",
  optional = true,
  dependencies = {
    {
      "hrsh7th/cmp-cmdline",
      keys = { ":", "/", "?" },
      dependencies = { "hrsh7th/nvim-cmp" },
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
  },
  opts = {
    completion = {
      completeopt = "menuone",
    },
    mapping = {
      ["<C-K>"] = cmp.mapping(
        function() cmp.select_prev_item { behavior = cmp.SelectBehavior.Select } end,
        { "i", "c" }
      ),
      ["<C-J>"] = cmp.mapping(
        function() cmp.select_next_item { behavior = cmp.SelectBehavior.Select } end,
        { "i", "c" }
      ),
      ["<C-N>"] = cmp.mapping(function()
        if luasnip.jumpable(1) then luasnip.jump(1) end
      end, { "i", "c" }),
      ["<C-P>"] = cmp.mapping(function()
        if luasnip.jumpable(-1) then luasnip.jump(-1) end
      end, { "i", "c" }),
      ["<Tab>"] = cmp.config.disable,
      ["<S-Tab>"] = cmp.config.disable,
    },
  },
}
