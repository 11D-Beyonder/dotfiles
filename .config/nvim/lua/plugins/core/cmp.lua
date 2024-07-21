local cmp = require "cmp"
local luasnip = require "luasnip"
return {
  "hrsh7th/nvim-cmp",
  optional = true,
  dependencies = {
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-emoji",
    "jc-doyle/cmp-pandoc-references",
    "kdheepak/cmp-latex-symbols",
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
        completeopt = "menuone,noselect",
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
        ["<Up>"] = cmp.config.disable,
        ["<Down>"] = cmp.config.disable,
        ["<C-E>"] = cmp.config.disable,
        ["<C-Space>"] = cmp.mapping(cmp.mapping.abort(), { "i", "c" }),
      },
      sources = cmp.config.sources {
        {
          -- NOTE: https://github.com/vuejs/language-tools/discussions/4495
          name = "nvim_lsp",
          entry_filter = function(entry, ctx)
            -- Check if the buffer type is 'vue'
            if ctx.filetype ~= "vue" then return true end

            local cursor_before_line = ctx.cursor_before_line
            -- For events
            if cursor_before_line:sub(-1) == "@" then
              return entry.completion_item.label:match "^@"
              -- For props also exclude events with `:on-` prefix
            elseif cursor_before_line:sub(-1) == ":" then
              return entry.completion_item.label:match "^:" and not entry.completion_item.label:match "^:on-"
            else
              return true
            end
          end,
          priority = 1000,
        },
        { name = "luasnip", priority = 750 },
        { name = "pandoc_references", priority = 725 },
        { name = "latex_symbols", priority = 700 },
        { name = "emoji", priority = 700 },
        { name = "calc", priority = 650 },
        { name = "path", priority = 500 },
        { name = "buffer", priority = 250 },
      },
      window = {
        completion = {
          col_offset = 1,
          side_padding = 1,
          scrollbar = true,
        },
      },
    })
  end,
}
