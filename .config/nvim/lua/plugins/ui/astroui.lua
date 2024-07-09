-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astroui",
  opts = {
    colorscheme = "bamboo",
    highlights = {
      init = function()
        local get_hlgroup = require("astroui").get_hlgroup
        local normal = get_hlgroup "Normal"
        local fg, bg = normal.fg, normal.bg
        local bg_alt = get_hlgroup("Visual").bg
        local green = get_hlgroup("String").fg
        local red = get_hlgroup("Error").fg
        return {
          TelescopeBorder = { fg = bg_alt, bg = bg },
          TelescopeNormal = { bg = bg },
          TelescopePreviewBorder = { fg = bg, bg = bg },
          TelescopePreviewNormal = { bg = bg },
          TelescopePreviewTitle = { fg = bg, bg = green },
          TelescopePromptBorder = { fg = bg_alt, bg = bg_alt },
          TelescopePromptNormal = { fg = fg, bg = bg_alt },
          TelescopePromptPrefix = { fg = red, bg = bg_alt },
          TelescopePromptTitle = { fg = bg, bg = red },
          TelescopeResultsBorder = { fg = bg, bg = bg },
          TelescopeResultsNormal = { bg = bg },
          TelescopeResultsTitle = { fg = bg, bg = bg },
        }
      end,
    },
    icons = {
      VimIcon = "",
      ScrollText = "",
      GitBranch = "",
      GitAdd = "",
      GitChange = "",
      GitDelete = "",
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },

    status = {
      separators = {
        left = { "", "" },
        right = { " ", "" },
        tab = { "", "" },
      },
      colors = function(hl)
        local get_hlgroup = require("astroui").get_hlgroup
        local comment_fg = get_hlgroup("Comment").fg
        hl.git_branch_fg = comment_fg
        hl.git_added = comment_fg
        hl.git_changed = comment_fg
        hl.git_removed = comment_fg
        hl.blank_bg = get_hlgroup("Folded").fg
        hl.file_info_bg = get_hlgroup("Visual").bg
        hl.nav_icon_bg = get_hlgroup("String").fg
        hl.nav_fg = hl.nav_icon_bg
        hl.folder_icon_bg = get_hlgroup("Error").fg
        return hl
      end,
      attributes = {
        mode = { bold = true },
      },
      icon_highlights = {
        file_icon = {
          statusline = false,
        },
      },
    },
  },
}
