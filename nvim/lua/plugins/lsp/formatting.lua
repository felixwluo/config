return {
	"stevearc/conform.nvim",

	event = { "BufReadPre", "BufNewFile" },
	lazy = true,
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports", "gofmt" },
				python = { "isort", "black" },
				cmake = { "cmake_format" },
				sh = { "shfmt" },
				json = { "jq" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
