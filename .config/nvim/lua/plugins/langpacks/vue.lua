local utils = require "astrocore"

-- NOTE: https://www.bilibili.com/video/BV1S6421Z7S6/
return {
  {
    "AstroNvim/astrolsp",
    opts = {
      config = {
        emmet_language_server = {
          filetypes = {
            "css",
            "eruby",
            "html",
            "htmldjango",
            "javascriptreact",
            "less",
            "pug",
            "sass",
            "scss",
            "typescriptreact",
            "vue",
          },
        },
        html = { init_options = { provideFormatter = false } },
        cssls = {
          init_options = { provideFormatter = false },
          settings = {
            css = {
              lint = {
                unknownAtRules = "ignore",
              },
            },
            less = {
              lint = {
                unknownAtRules = "ignore",
              },
            },
            scss = {
              validate = false,
              lint = {
                unknownAtRules = "ignore",
              },
            },
          },
        },
        volar = {
          on_attach = function(client, _)
            client.server_capabilities = utils.extend_tbl(client.server_capabilities, {
              workspace = {
                didChangeWatchedFiles = { dynamicRegistration = true },
              },
            })
          end,
          init_options = {
            vue = {
              hybridMode = true,
            },
          },
          settings = {
            vue = {
              updateImportsOnFileMove = { enabled = true },
            },
          },
        },
        vtsls = {
          on_attach = function(client, _)
            client.server_capabilities = utils.extend_tbl(client.server_capabilities, {
              workspace = {
                didChangeWatchedFiles = { dynamicRegistration = true },
                fileOperations = {
                  -- NOTE: 更改文件名后自动重命名引用
                  didRename = {
                    filters = {
                      {
                        pattern = {
                          glob = "**/*.{ts,cts,mts,tsx,js,cjs,mjs,jsx,vue}",
                        },
                      },
                    },
                  },
                },
              },
            })
          end,
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "vue",
          },
          settings = {
            complete_function_calls = true,
            vtsls = {
              tsserver = {
                globalPlugins = {},
              },
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
            },
            javascript = {
              updateImportsOnFileMove = { enabled = "always" },
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
            },
          },
          before_init = function(_, config)
            local astrocore_ok, astrocore = pcall(require, "astrocore")
            local registry_ok, registry = pcall(require, "mason-registry")
            if not astrocore_ok or not registry_ok then return end

            local volar_install_path = registry.get_package("vue-language-server"):get_install_path()
              .. "/node_modules/@vue/language-server"

            local vue_plugin_config = {
              name = "@vue/typescript-plugin",
              location = volar_install_path,
              languages = { "vue" },
              configNamespace = "typescript",
              enableForWorkspaceTypeScriptVersions = true,
            }

            astrocore.list_insert_unique(config.settings.vtsls.tsserver.globalPlugins, { vue_plugin_config })
          end,
        },
        tailwindcss = {
          root_dir = function(fname)
            local root_pattern = require("lspconfig").util.root_pattern(
              "tailwind.config.cjs",
              "tailwind.config.js",
              "tailwind.config.ts",
              "postcss.config.js",
              "config/tailwind.config.js"
            )
            return root_pattern(fname)
          end,
          settings = {
            tailwindCSS = {
              classAttributes = {
                "class",
                "className",
                "ngClass",
                "classList",
              },
              experimental = {
                classRegex = {
                  { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                  { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                  {
                    "tw`([^`]*)",
                    'tw="([^"]*)',
                    'tw={"([^"}]*)',
                    "tw\\.\\w+`([^`]*)",
                    "tw\\(.*?\\)`([^`]*)",
                  },
                },
              },
              includeLanguages = {
                typescript = "javascript",
                typescriptreact = "javascript",
              },
              emmetCompletions = false,
              validate = true,
              lint = {
                cssConflict = "warning",
                invalidApply = "error",
                invalidConfigPath = "error",
                invalidScreen = "error",
                invalidTailwindDirective = "error",
                invalidVariant = "error",
                recommendedVariantOrder = "warning",
              },
            },
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = utils.list_insert_unique(
          opts.ensure_installed,
          { "html", "css", "scss", "javascript", "typescript", "tsx", "jsdoc", "vue" }
        )
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = utils.list_insert_unique(
        opts.ensure_installed,
        { "html", "cssmodules_ls", "emmet_language_server", "vtsls", "volar", "tailwindcss" }
      )
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts) opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "prettierd" }) end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts) opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "js" }) end,
  },
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
    event = "BufRead package.json",
  },
  {
    "dmmulroy/tsc.nvim",
    cmd = { "TSC" },
    opts = {},
  },
  { "dmmulroy/ts-error-translator.nvim", opts = {}, ft = { "typescript", "vue" } },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    config = function()
      local dap = require "dap"
      if not dap.adapters["pwa-node"] then
        require("dap").adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = {
              require("mason-registry").get_package("js-debug-adapter"):get_install_path()
                .. "/js-debug/src/dapDebugServer.js",
              "${port}",
            },
          },
        }
      end
      if not dap.adapters["node"] then
        dap.adapters["node"] = function(cb, config)
          if config.type == "node" then config.type = "pwa-node" end
          local nativeAdapter = dap.adapters["pwa-node"]
          if type(nativeAdapter) == "function" then
            nativeAdapter(cb, config)
          else
            cb(nativeAdapter)
          end
        end
      end

      local js_filetypes = { "typescriptreact", "typescript", "javascript", "javascriptreact" }

      local vscode = require "dap.ext.vscode"
      vscode.type_to_filetypes["node"] = js_filetypes
      vscode.type_to_filetypes["pwa-node"] = js_filetypes

      for _, language in ipairs(js_filetypes) do
        if not dap.configurations[language] then
          dap.configurations[language] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
            },
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
            },
          }
        end
      end
    end,
  },
  {
    "yioneko/nvim-vtsls",
    lazy = true,
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
          nvim_vtsls = {
            {
              event = "LspAttach",
              desc = "Load nvim-vtsls with vtsls",
              callback = function(args)
                if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "vtsls" then
                  require("vtsls")._on_attach(args.data.client_id, args.buf)
                  vim.api.nvim_del_augroup_by_name "nvim_vtsls"
                end
              end,
            },
          },
        },
      },
    },
    config = function(_, opts) require("vtsls").config(opts) end,
  },
  {
    "marilari88/neotest-vitest",
    dependencies = {
      "nvim-neotest/neotest",
      opts = function(_, opts)
        if not opts.adapters then opts.adapters = {} end
        table.insert(opts.adapters, require "neotest-vitest"(require("astrocore").plugin_opts "neotest-vitest"))
      end,
    },
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = {
      { "js-everts/cmp-tailwind-colors", opts = {} },
    },
    opts = function(_, opts)
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        if item.kind == "Color" then
          item = require("cmp-tailwind-colors").format(entry, item)
          if item.kind == "Color" then return format_kinds(entry, item) end
          return item
        end
        return format_kinds(entry, item)
      end
    end,
  },
}
