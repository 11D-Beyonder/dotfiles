return {
  {
    "AstroNvim/astrolsp",
    optional = true,
    opts = function(_, opts)
      opts.config = vim.tbl_deep_extend("keep", opts, {
        clangd = {
          capabilities = {
            offsetEncoding = "utf-8",
          },
          cmd = {
            "clangd",
            "--fallback-style=webkit",
            "--offset-encoding=utf-8",
            "--clang-tidy",
            "--completion-style=detailed",
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "cpp", "c" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "clangd" })
    end,
  },
  {
    "p00f/clangd_extensions.nvim",
    ft = { "*.c", "*.cpp", "*.h", "*.hpp" },
    config = true,
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = {
          autocmds = {
            clangd_extensions = {
              {
                event = "LspAttach",
                desc = "Load clangd_extensions with clangd",
                callback = function(args)
                  if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "clangd" then
                    require("clangd_extensions.inlay_hints").setup_autocmd()
                    require("clangd_extensions.inlay_hints").set_inlay_hints()
                  end
                end,
              },
            },
            clangd_extension_mappings = {
              {
                event = "LspAttach",
                desc = "Load clangd_extensions with clangd",
                callback = function(args)
                  if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "clangd" then
                    require("astrocore").set_mappings({
                      n = {
                        ["<Leader>lw"] = { "<Cmd>ClangdSwitchSourceHeader<CR>", desc = "Switch source/header file" },
                      },
                    }, { buffer = args.buf })
                  end
                end,
              },
            },
          },
        },
      },
    },
    {

      "hrsh7th/nvim-cmp",
      optional = true,
      opts = function(_, opts)
        local cmp = require "cmp"
        opts.sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.recently_used,
            require "clangd_extensions.cmp_scores",
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        }
      end,
    },
  },
}
