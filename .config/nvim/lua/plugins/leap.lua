return {
	{
		"ggandor/leap.nvim",
		dependencies = {
			"tpope/vim-repeat",
		},
		event = { "BufEnter" },
		config = function()
			require("leap").create_default_mappings()
		end,
	},
}
