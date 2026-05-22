return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  dependencies = {
    {
      "folke/snacks.nvim",
      opts = {
        input = {},
        picker = {
          actions = {
            opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    local tcp = assert(vim.uv.new_tcp())
    assert(tcp:bind("127.0.0.1", 0))
    local opencode_port = assert(tcp:getsockname()).port
    tcp:close()

    local opencode_cmd = ("opencode serve --port %d"):format(opencode_port)
    local opencode_attach_cmd = ("ocv attach http://127.0.0.1:%d"):format(opencode_port)
    local opencode_url = ("http://127.0.0.1:%d"):format(opencode_port)
    local opencode_job_id

    local function opencode_terminal_opts()
      return {
        split = "right",
        width = math.floor(vim.o.columns * 0.35),
      }
    end

    local function opencode_start()
      if opencode_job_id then
        return
      end

      opencode_job_id = vim.fn.jobstart(opencode_cmd, {
        on_exit = function()
          opencode_job_id = nil
        end,
      })

      assert(opencode_job_id > 0, "failed to start opencode server")
    end

    local function opencode_stop()
      if opencode_job_id then
        vim.fn.jobstop(opencode_job_id)
        opencode_job_id = nil
      end
    end

    opencode_start()

    vim.api.nvim_create_autocmd("ExitPre", {
      once = true,
      callback = opencode_stop,
    })

    vim.api.nvim_create_user_command("OpencodeAttachCommand", function()
      vim.fn.setreg("+", opencode_attach_cmd)
      vim.notify("Copied: " .. opencode_attach_cmd, vim.log.levels.INFO, { title = "opencode" })
    end, { desc = "Copy the command to attach to this Neovim's opencode server" })

    vim.g.opencode_opts = {
      server = {
        url = opencode_url,
        start = opencode_start,
        stop = opencode_stop,
        toggle = function()
          require("opencode.terminal").toggle(opencode_attach_cmd, opencode_terminal_opts())
        end,
      },
    }
    vim.o.autoread = true

    vim.keymap.set({ "n", "x" }, "<leader>oa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode" })

    vim.keymap.set({ "n", "x" }, "<leader>os", function()
      require("opencode").select()
    end, { desc = "Select opencode" })

    vim.keymap.set({ "n", "t" }, "<leader>ot", function()
      require("opencode").toggle()
    end, { desc = "Toggle opencode" })

    vim.keymap.set({ "n", "x" }, "go", function()
      return require("opencode").operator("@this ")
    end, { desc = "Add range to opencode", expr = true })

    vim.keymap.set("n", "goo", function()
      return require("opencode").operator("@this ") .. "_"
    end, { desc = "Add line to opencode", expr = true })

    vim.keymap.set("n", "<leader>ou", function()
      require("opencode").command("session.half.page.up")
    end, { desc = "Scroll opencode up" })

    vim.keymap.set("n", "<leader>od", function()
      require("opencode").command("session.half.page.down")
    end, { desc = "Scroll opencode down" })
  end,
}
