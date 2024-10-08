if not vim.g.vscode then return {} end -- don't do anything in non-vscode instances

local enabled = {}
vim.tbl_map(function(plugin) enabled[plugin] = true end, {
  -- core plugins
  "lazy.nvim",
  "AstroNvim",
  "astrocore",
  "astroui",
  "Comment.nvim",
  "nvim-autopairs",
  "nvim-treesitter",
  "nvim-ts-autotag",
  "nvim-treesitter-textobjects",
  "nvim-ts-context-commentstring",
  -- more known working
  "flash.nvim",
})

local Config = require "lazy.core.config"
-- disable plugin update checking
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
-- replace the default `cond`
Config.options.defaults.cond = function(plugin) return enabled[plugin.name] end
Config.options.defaults.lazy = false

---@type LazySpec
return {
  -- disable colorscheme setting
  { "AstroNvim/astroui", opts = { colorscheme = false } },
  -- disable treesitter highlighting
  { "nvim-treesitter/nvim-treesitter", opts = { highlight = { enable = false } } },
  -- add a few keybindings
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      local maps = assert(opts.mappings)

      -- basic actions
      -- maps.n["<Leader>q"] = function() require("vscode-neovim").action "workbench.action.closeWindow" end
      maps.n["<Leader>w"] = function() require("vscode-neovim").action "workbench.action.files.save" end
      -- maps.n["<Leader>n"] = function() require("vscode-neovim").action "welcome.showNewFileEntries" end

      -- splits navigation
      maps.n["|"] = function() require("vscode").action "workbench.action.splitEditor" end
      maps.n["\\"] = function() require("vscode").action "workbench.action.splitEditorDown" end
      maps.n["<C-H>"] = function() require("vscode").action "workbench.action.navigateLeft" end
      maps.n["<C-J>"] = function() require("vscode").action "workbench.action.navigateDown" end
      maps.n["<C-K>"] = function() require("vscode").action "workbench.action.navigateUp" end
      maps.n["<C-L>"] = function() require("vscode").action "workbench.action.navigateRight" end

      -- buffer management
      maps.n["]b"] = "<Cmd>Tabnext<CR>"
      maps.n["[b"] = "<Cmd>Tabprevious<CR>"
      maps.n["<Leader>c"] = "<Cmd>Tabclose<CR>"
      maps.n["<Leader>C"] = "<Cmd>Tabclose!<CR>"
      maps.n["<Leader>bp"] = "<Cmd>Tablast<CR>"

      -- side bar
      maps.n["<Leader>e"] = function() require("vscode").action "workbench.files.action.focusFilesExplorer" end
      maps.n["<Leader>g"] = function() require("vscode").action "workbench.view.scm" end
      maps.n["<Leader>t"] = function() require("vscode").action "workbench.view.extension.test" end
      maps.n["<Leader>d"] = function() require("vscode").action "workbench.view.debug" end
      maps.n["<Leader>x"] = function() require("vscode").action "workbench.view.extensions" end

      -- indentation"workbench.action.toggleSidebarVisibility"
      maps.v["<Tab>"] = function() require("vscode").action "editor.action.indentLines" end
      maps.v["<S-Tab>"] = function() require("vscode").action "editor.action.outdentLines" end

      -- diagnostics
      maps.n["]d"] = function() require("vscode").action "editor.action.marker.nextInFiles" end
      maps.n["[d"] = function() require("vscode").action "editor.action.marker.prevInFiles" end

      -- pickers (emulate telescope mappings)
      maps.n["<Leader>fc"] = function()
        require("vscode-neovim").action("workbench.action.findInFiles", { args = { query = vim.fn.expand "<cword>" } })
      end
      maps.n["<Leader>fC"] = function() require("vscode").action "workbench.action.showCommands" end
      maps.n["<Leader>ff"] = function() require("vscode").action "workbench.action.quickOpen" end
      maps.n["<Leader>fn"] = function() require("vscode").action "notifications.showList" end
      maps.n["<Leader>fo"] = function() require("vscode").action "workbench.action.openRecent" end
      maps.n["<Leader>ft"] = function() require("vscode").action "workbench.action.selectTheme" end
      maps.n["<Leader>fw"] = function() require("vscode").action "workbench.action.findInFiles" end

      -- LSP Mappings
      maps.n["gh"] = function() require("vscode").action "editor.action.showDefinitionPreviewHover" end
      maps.n["gI"] = function() require("vscode").action "editor.action.goToImplementation" end
      maps.n["gd"] = function() require("vscode").action "editor.action.revealDefinition" end
      maps.n["gD"] = function() require("vscode").action "editor.action.revealDeclaration" end
      maps.n["gr"] = function() require("vscode").action "editor.action.goToReferences" end
      maps.n["gy"] = function() require("vscode").action "editor.action.goToTypeDefinition" end
      maps.n["<Leader>la"] = function() require("vscode").action "editor.action.quickFix" end
      maps.n["<Leader>lS"] = function() require("vscode").action "workbench.action.showAllSymbols" end
      maps.n["<Leader>lr"] = function() require("vscode").action "editor.action.rename" end
      maps.n["<Leader>ls"] = function() require("vscode").action "workbench.action.gotoSymbol" end
      maps.n["<Leader>lf"] = function() require("vscode").action "editor.action.formatDocument" end
    end,
  },
}
