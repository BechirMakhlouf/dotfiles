--@type ChadrcConfig

local M = {}

vim.opt.relativenumber = true

M.ui = { theme = 'ayu_dark' }

M.mappings = require "custom.mappings"
M.plugins = "custom.plugins"

return M
