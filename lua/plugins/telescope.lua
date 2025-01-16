return {
  "nvim-telescope/telescope.nvim",
  -- replace all Telescope keymaps with only one mapping
  keys = function()
    return {
	    {"<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope Find Files" },
	    {"<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Telescope Live Grep"  },
	    {"<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Telescope buffers"    },
	    {"<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Telescope help tags"  },
    }
  end,
}
