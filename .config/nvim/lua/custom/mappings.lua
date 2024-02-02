---@type MappingsTable
local M = {}

M.general = {
  n = {
    -- [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },

    ["<leader>ss"] = {"<cmd>wa<CR>", "save all"},
    ["<leader>sq"] = {"<cmd>wqa!<CR>", "save quit all"},
    ["<leader>qq"] = {"<cmd>qa!<CR>", "quit all"},
  },
}

M.nvimtree = {
  n = {
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Focus nvimtree" },
  }
}
-- more keybinds!

return M
