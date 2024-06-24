return {
	{
		"nvim-pack/nvim-spectre",
		lazy = true,
		cmd = { "Spectre" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- "catppuccin/nvim",
		},
		config = function()
			-- local theme = require("catppuccin.palettes").get_palette("macchiato")
			local theme = require("tokyonight.colors")
			vim.api.nvim_set_hl(0, "SpectreSearch", { bg = theme.default.red, fg = theme.default.fg })
			vim.api.nvim_set_hl(0, "SpectreReplace", { bg = theme.default.green, fg = theme.default.fg })

			require("spectre").setup({
				highlight = {
					search = "SpectreSearch",
					replace = "SpectreReplace",
				},
				mapping = {
					["send_to_qf"] = {
						map = "<C-q>",
						cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
						desc = "send all items to quickfix",
					},
				},
				replace_engine = {
					sed = {
						cmd = "sed",
					},
				},
			})
		end,
	},
}
