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
  opts = function(_, opts)
    local function trim(s)
      if s == nil then return "" end
      return (s:gsub("^%s*(.-)%s*$", "%1"))
    end
    local function truncateString(s, maxLength)
      if #s > maxLength then
        return string.sub(s, 1, maxLength) .. "..."
      else
        return s
      end
    end
    local function getMethodName(s) return string.gsub(s, "%(.*%)", "") end

    return require("astrocore").extend_tbl(opts, {
      completion = {
        completeopt = "menuone",
      },
      formatting = {
        fields = { "abbr", "menu", "kind" },
        format = function(_, item)
          local icons = require "icons.lspkind"
          local icon = icons[item.kind] or ""
          item.kind = string.format("%s %s ", icon, trim(item.kind))
          item.abbr = getMethodName(trim(item.abbr))
          item.menu = truncateString(trim(item.menu), 10)
          return item
        end,
      },
      mapping = {
        ["<S-Tab>"] = cmp.mapping(
          function() cmp.select_prev_item { behavior = cmp.SelectBehavior.Select } end,
          { "i", "c" }
        ),
        ["<Tab>"] = cmp.mapping(
          function() cmp.select_next_item { behavior = cmp.SelectBehavior.Select } end,
          { "i", "c" }
        ),
        ["<C-N>"] = cmp.mapping(function()
          if luasnip.jumpable(1) then luasnip.jump(1) end
        end, { "i", "c" }),
        ["<C-P>"] = cmp.mapping(function()
          if luasnip.jumpable(-1) then luasnip.jump(-1) end
        end, { "i", "c" }),
      },
      window = {
        completion = {
          col_offset = 1,
          side_padding = 1,
          scrollbar = false,
        },
      },
    })
  end,
}
