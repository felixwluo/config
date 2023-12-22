return {
	"willothy/nvim-cokeline",
	config = function()
		local get_hex = require("cokeline.hlgroups").get_hl_attr
		require("cokeline").setup({
			show_if_buffers_are_at_least = 2,
			default_hl = {
				fg = function(buffer)
					return buffer.is_focused and get_hex("ColorColumn", "bg") or get_hex("Normal", "fg")
				end,
				bg = function(buffer)
					return buffer.is_focused and get_hex("Normal", "fg") or get_hex("ColorColumn", "bg")
				end,
			},
			components = {
				{
					text = function(buffer)
						return " " .. buffer.index .. ": " .. buffer.filename .. " "
					end,
				},
				{
					text = function(buffer)
						return buffer.is_modified and "●" or "✘"
					end,
					fg = function(buffer)
						if buffer.is_modified then
							return "Orange"
						elseif buffer.is_focused then
							return "DarkGreen"
						else
							return "LightGreen"
						end
					end,
					delete_buffer_on_left_click = true,
				},
				{
					text = " ",
				},
			},
		})

		local map = vim.api.nvim_set_keymap

		map("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)", { silent = true })
		map("n", "<Tab>", "<Plug>(cokeline-focus-next)", { silent = true })
		map("n", "<Leader>p", "<Plug>(cokeline-switch-prev)", { silent = true })
		map("n", "<Leader>n", "<Plug>(cokeline-switch-next)", { silent = true })

		for i = 1, 9 do
			map("n", ("<F%s>"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), { silent = true })
			map("n", ("<Leader>%s"):format(i), ("<Plug>(cokeline-switch-%s)"):format(i), { silent = true })
		end
	end,
}
