return {
    "tpope/vim-fugitive",
    keys = function()
      return {
          {"<c-g>", "<cmd>Git blame<cr>", desc = "Fugitive git blame"},
      }
    end,
}
