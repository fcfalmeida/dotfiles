return {
	"NickvanDyke/opencode.nvim",
	dependencies = {
		---@module "snacks"
		{
			"folke/snacks.nvim",
			opts = {
				input = {},
				picker = {
					actions = {
						opencode_send = function(...)
							return require("opencode").snacks_picker_send(...)
						end,
					},
				},
			},
		},
	},
	config = function()
		local opencode_cmd = "opencode --continue --port"

		local snacks_terminal_opts = {
			win = {
				position = "right",
				wo = {
					winblend = 100,
					winhighlight = "NormalFloat:MyTransparentGroup",
				},
			},
		}

		---@type opencode.Opts
		vim.g.opencode_opts = {
			server = {
				start = function()
					require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
				end,
				stop = function()
					require("snacks.terminal").get(opencode_cmd, snacks_terminal_opts):close()
				end,
				toggle = function()
					require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
				end,
			},
		}
	end,
	keys = {
		{
			mode = { "n", "t" },
			"<C-q>",
			function()
				require("opencode").toggle()
			end,
			desc = "Toggle opencode",
		},
		{
			mode = { "n", "x" },
			"<leader>a",
			function()
				require("opencode").ask()
			end,
			desc = "Ask opencode",
		},
	},
}
