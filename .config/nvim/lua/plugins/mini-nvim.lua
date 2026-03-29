return {
	"nvim-mini/mini.nvim",
	version = false,
	lazy = false,
	config = function()
		require("mini.icons").setup()
		require("mini.ai").setup({ n_lines = 500 })
		require("mini.pairs").setup()
		require("mini.surround").setup()
		require("mini.trailspace").setup()
		-- require('mini.bufremove').setup()

		-- STATUSLINE
		local statusline = require("mini.statusline")
		statusline.setup({ use_icons = vim.g.have_nerd_font })

		statusline.section_location = function()
			return "%2l:%-2v"
		end
	end,
}
