-- Configuration for Claude Code Neovim plugin
-- Defines keybindings for interacting with Claude Code from within Neovim
return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  keys = {
    --{ "<leader>c", nil, desc = "AI/Claude Code" },
    { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    --{ "<leader>hf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    --{ "<leader>hr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    --{ "<leader>hC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    --{ "<leader>hm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    { "<leader>cs", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    --{
    --  "<leader>hs",
    --  "<cmd>ClaudeCodeTreeAdd<cr>",
    --  desc = "Add file",
    --  ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
    --},
    -- Diff management
    { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
}
