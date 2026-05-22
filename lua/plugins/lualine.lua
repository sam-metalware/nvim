return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
--      options = {
--          component_separators = "|",
--          section_separators = "",
--      },
      sections = {
        lualine_b = {
          "branch",
          {
            function()
              return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
            end,
            --icon = "cwd",
          },
        },
      },
    })
  end,
}
