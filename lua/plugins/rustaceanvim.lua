vim.g.rustaceanvim = {
  server = {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
    on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }

      -- Enable inlay hints
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end

      -- Enable semantic tokens
      if client.server_capabilities.semanticTokensProvider then
        vim.api.nvim_set_hl(0, '@lsp.type.comment', {})
      end

      -- Navigation
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

      -- Documentation
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, opts)

      -- Code actions
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

      -- Workspace
      vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)

      -- Diagnostics
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
      vim.keymap.set('n', 'cd', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

      -- Toggle inlay hints
      vim.keymap.set('n', '<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
      end, { desc = 'Toggle inlay hints', buffer = bufnr })

      -- Code lens
      if client.server_capabilities.codeLensProvider then
        vim.lsp.codelens.refresh()
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
          buffer = bufnr,
          callback = vim.lsp.codelens.refresh,
        })
        vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, { desc = 'Run code lens', buffer = bufnr })
      end

      -- Debuggables
      vim.keymap.set("n", "<leader>rd", function()
        vim.cmd.RustLsp("debuggables")
      end, { desc = "Rust Debuggables", buffer = bufnr })

      -- Runnables
      vim.keymap.set("n", "<leader>rr", function()
        vim.cmd.RustLsp("runnables")
      end, { desc = "Rust Runnables", buffer = bufnr })

      -- Parent module
      vim.keymap.set("n", "<leader>p", function()
        vim.cmd.RustLsp("parentModule")
      end, { desc = "Rust Parent Module", buffer = bufnr })

      -- Autoformat on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end,
    default_settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          buildScripts = {
            enable = true,
          },
        },
        checkOnSave = {
          enable = true,
          command = "check",
        },
        diagnostics = {
          enable = true,
        },
        procMacro = {
          enable = true,
          ignored = {
            ["async-trait"] = { "async_trait" },
            ["napi-derive"] = { "napi" },
            ["async-recursion"] = { "async_recursion" },
          },
        },
        inlayHints = {
          bindingModeHints = {
            enable = true,
          },
          chainingHints = {
            enable = true,
          },
          closingBraceHints = {
            minLines = 10,
          },
          closureReturnTypeHints = {
            enable = "always",
          },
          lifetimeElisionHints = {
            enable = "skip_trivial",
            useParameterNames = true,
          },
          parameterHints = {
            enable = false,
          },
          typeHints = {
            enable = true,
            --enable = true,
            hideClosureInitialization = false,
            hideNamedConstructor = false,
          },
        },
        files = {
          excludeDirs = {
            ".direnv",
            ".git",
            ".github",
            ".gitlab",
            "bin",
            "node_modules",
            "target",
            "venv",
            ".venv",
          },
        },
      },
    },
  },
}

return {
  "mrcjkb/rustaceanvim",
  version = '^6',
  lazy = false,
  ft = { "rust" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-mini/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "stevearc/dressing.nvim", -- for input provider dressing
    "folke/snacks.nvim", -- for input provider snacks
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    },
}
