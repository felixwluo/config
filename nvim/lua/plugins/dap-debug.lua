return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			config = function()
				require("dapui").setup({})
			end,
		},
		{
			"theHamsta/nvim-dap-virtual-text",
			config = function()
				require("nvim-dap-virtual-text").setup({})
			end,
		},
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		-- Events
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- Configurations
		dap.adapters.lldb = {
			type = "executable",
			command = "/data/home/felixwluo/.local/share/nvim/mason/bin/codelldb", -- adjust as needed, must be absolute path
			name = "lldb",
		}

		dap.adapters.lldb = {
			type = "server",
			port = "${port}",
			executable = {
				-- CHANGE THIS to your path!
				command = "/data/home/felixwluo/.local/share/nvim/mason/bin/codelldb",
				args = { "--port", "${port}" },

				-- On windows you may have to uncomment this:
				-- detached = false,
			},
		}

		dap.configurations.cpp = {
			{
				name = "Launch",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				initCommands = function()
					if vim.fn.filereadable(vim.fn.getcwd() .. "/.lldbinit") == 1 then
						return { "command source ${workspaceFolder}/.lldbinit" }
					end
					return {}
				end,
				stopOnEntry = false,
				args = {},
			},
		}

		dap.configurations.c = dap.configurations.cpp

		vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = " ", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "", linehl = "", numhl = "" })

		vim.keymap.set("n", "<m-k>", function()
			require("dap").continue()
		end)
		vim.keymap.set("n", "<m-j>", function()
			require("dap").step_over()
		end)
		vim.keymap.set("n", "<m-l>", function()
			require("dap").step_into()
		end)
		vim.keymap.set("n", "<m-h>", function()
			require("dap").step_out()
		end)
		vim.keymap.set("n", "<m-b>", function()
			require("dap").toggle_breakpoint()
		end)
		vim.keymap.set("n", "<m-B>", function()
			require("dap").set_breakpoint()
		end)
		vim.keymap.set("n", "<m-p>", function()
			require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		end)
		vim.keymap.set("n", "<m-c>", function()
			require("dap").set_breakpoint(vim.fn.input("Condition: "), nil, nil)
		end)
		vim.keymap.set("n", "<m-d>", function()
			require("dapui").eval()
		end)
		vim.keymap.set("n", "<m-f>", function()
			require("dapui").eval(vim.fn.input("Expression: "), { context = "repl" })
		end)

		require("dap.ext.vscode").load_launchjs(nil, {
			["lldb"] = { "cpp", "c" },
		})
	end,
}
