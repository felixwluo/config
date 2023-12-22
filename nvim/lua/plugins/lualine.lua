return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "BufEnter",
	config = function()
		local lualine = require("lualine")
		lualine.setup({
			options = {
				theme = "powerline",
			},
			sections = {
				lualine_c = {
					{
						"filename",
						file_status = false,
						path = 2,
					},
				},
			},
		})
	end,
}
