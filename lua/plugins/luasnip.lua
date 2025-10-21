return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local luasnip = require("luasnip")

    -- Load snippets from friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Keymaps for snippet navigation
    vim.keymap.set({"i", "s"}, "<C-l>", function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { silent = true, desc = "LuaSnip: Expand or jump forward" })

    vim.keymap.set({"i", "s"}, "<C-h>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { silent = true, desc = "LuaSnip: Jump backward" })

    vim.keymap.set({"i", "s"}, "<C-j>", function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end, { silent = true, desc = "LuaSnip: Change choice" })
  end,
}
