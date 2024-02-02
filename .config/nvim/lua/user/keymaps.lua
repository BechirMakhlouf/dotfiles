local nnoremap = require("user.keymap_utils").nnoremap
-- local vnoremap = require("user.keymap_utils").vnoremap
-- local inoremap = require("user.keymap_utils").inoremap
-- local tnoremap = require("user.keymap_utils").tnoremap
-- local xnoremap = require("user.keymap_utils").xnoremap

-- Normal --

-- Disable Space bar since it'll be used as the leader key
nnoremap("<space>", "<nop>")



-- oil
nnoremap("<leader>e", function()
	require("oil").toggle_float()
end)

-- Center buffer while navigating
nnoremap("<C-u>", "<C-u>zz")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("{", "{zz")
nnoremap("}", "}zz")
nnoremap("N", "Nzz")
nnoremap("n", "nzz")
nnoremap("G", "Gzz")
nnoremap("gg", "ggzz")
nnoremap("<C-i>", "<C-i>zz")
nnoremap("<C-o>", "<C-o>zz")
nnoremap("%", "%zz")
nnoremap("*", "*zz")
nnoremap("#", "#zz")
