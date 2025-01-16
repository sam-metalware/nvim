return {
    "tpope/vim-fugitive",
    keys = function()
      return {
          {"<leader>gb", "<cmd>Git blame<cr>", desc = "Fugitive git blame"},
      }
    end,
}
