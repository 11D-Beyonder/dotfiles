return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "java" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "jdtls", "lemminx" })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "javadbg", "javatest" })
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      {
        "AstroNvim/astrolsp",
        optional = true,
        opts = {
          handlers = { jdtls = false },
        },
      },
    },
    opts = function(_, opts)
      local utils = require "astrocore"
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local workspace_dir = vim.fn.stdpath "data" .. "/site/java/workspace-root/" .. project_name
      vim.fn.mkdir(workspace_dir, "p")

      -- validate operating system
      if not (vim.fn.has "mac" == 1 or vim.fn.has "unix" == 1 or vim.fn.has "win32" == 1) then
        utils.notify("jdtls: Could not detect valid OS", vim.log.levels.ERROR)
      end

      return utils.extend_tbl({
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-javaagent:" .. vim.fn.expand "$MASON/share/jdtls/lombok.jar",
          "-Xms1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-jar",
          vim.fn.expand "$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher.jar",
          "-configuration",
          vim.fn.expand "$MASON/share/jdtls/config",
          "-data",
          workspace_dir,
        },
        root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml" }),
        settings = {
          java = {
            eclipse = { downloadSources = true },
            configuration = { updateBuildConfiguration = "interactive" },
            maven = { downloadSources = true },
            implementationsCodeLens = { enabled = true },
            referencesCodeLens = { enabled = true },
            inlayHints = { parameterNames = { enabled = "all" } },
            signatureHelp = { enabled = true },
            completion = {
              favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
              },
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
          },
        },
        init_options = {
          bundles = {
            vim.fn.expand "$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar",
            (table.unpack or unpack)(vim.split(vim.fn.glob "$MASON/share/java-test/*.jar", "\n", {})),
          },
        },
        filetypes = { "java" },
        on_attach = function(...)
          require("jdtls").setup_dap { config_overrides = {}, hotcodereplace = "auto" }
          local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
          if astrolsp_avail then astrolsp.on_attach(...) end
        end,
      }, opts)
    end,
    config = function(_, opts)
      vim.api.nvim_create_autocmd("Filetype", {
        pattern = "java",
        callback = function() require("jdtls").start_or_attach(opts) end,
      })
      vim.api.nvim_create_autocmd("LspAttach", {
        pattern = "*.java",
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client ~= nil and client.name == "jdtls" then require("jdtls.dap").setup_dap_main_class_configs() end
        end,
      })
    end,
  },
  {
    "rcasia/neotest-java",
    ft = "java",
    cmd = "NeotestJava",
    dependencies = {
      "nvim-neotest/neotest",
      opts = function(_, opts)
        if not opts.adapters then opts.adapters = {} end
        table.insert(opts.adapters, require "neotest-java" {})
      end,
    },
  },
  {
    "eatgrass/maven.nvim",
    cmd = { "Maven", "MavenExec" },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "AstroNvim/astrocore",
        opts = {
          autocmds = {
            dev_java = {
              {
                event = "VimEnter",
                pattern = "*",
                -- group = "dev_java",
                callback = function()
                  if vim.fn.findfile("pom.xml", vim.fn.getcwd() .. ";") ~= "" then
                    require("astrocore").set_mappings {
                      n = {
                        ["<Leader>lm"] = {
                          "<cmd>Maven<cr>",
                          desc = "Execute maven goal.",
                        },
                      },
                    }
                  end
                end,
              },
            },
          },
        },
      },
    },
    opts = {
      executable = "mvn",
      commands = {
        { cmd = { "spring-boot:run" }, desc = "start SpringBoot" },
      },
    },
  },
}
