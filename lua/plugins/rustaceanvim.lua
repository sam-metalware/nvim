-- Configure rustaceanvim via global variable
vim.g.rustaceanvim = {
  server = {
    on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      
      -- Navigation
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      
      -- Documentation
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      
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
      vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

      -- Rust-specific code actions
      -- vim.keymap.set("n", "<leader>c", function()
      --   vim.cmd.RustLsp("codeAction")
      -- end, { desc = "Code Action", buffer = bufnr })

      -- Debuggables
      vim.keymap.set("n", "<leader>rd", function()
        vim.cmd.RustLsp("debuggables")
      end, { desc = "Rust Debuggables", buffer = bufnr })

      -- Runnables
      vim.keymap.set("n", "<leader>rr", function()
        vim.cmd.RustLsp("runnables")
      end, { desc = "Rust Runnables", buffer = bufnr })

      -- Hover actions
      -- vim.keymap.set("n", "<leader>h", function()
      --   vim.cmd.RustLsp({ "hover", "actions" })
      -- end, { desc = "Rust Hover Actions", buffer = bufnr })

      -- Explain errors
      -- vim.keymap.set("n", "<leader>e", function()
      --   vim.cmd.RustLsp("explainError")
      -- end, { desc = "Rust Explain Error", buffer = bufnr })

      -- Expand macro
      -- vim.keymap.set("n", "<leader>m", function()
      --   vim.cmd.RustLsp("expandMacro")
      -- end, { desc = "Rust Expand Macro", buffer = bufnr })

      -- Parent module
      vim.keymap.set("n", "<leader>p", function()
        vim.cmd.RustLsp("parentModule")
      end, { desc = "Rust Parent Module", buffer = bufnr })


      -- Join lines (already have this macro)
      --vim.keymap.set("n", "<leader>rj", function()
      --  vim.cmd.RustLsp("joinLines")
      --end, { desc = "Rust Join Lines", buffer = bufnr })

      -- Structural search replace
      -- vim.keymap.set("n", "<leader>sr", function()
      --   vim.cmd.RustLsp("ssr")
      -- end, { desc = "Rust Structural Search Replace", buffer = bufnr })

      -- View crate graph
      -- vim.keymap.set("n", "<leader>rc", function()
      --   vim.cmd.RustLsp("crateGraph")
      -- end, { desc = "Rust Crate Graph", buffer = bufnr })

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
}
