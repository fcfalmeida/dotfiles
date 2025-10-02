return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				disabled_filetypes = { "neo-tree", "snacks_terminal" },
			},
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		lazy = false,
		opts = {
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
				},
				follow_current_file = {
					enabled = true,
				},
			},
		},
		config = function(_, opts)
			vim.api.nvim_create_autocmd("User", {
				pattern = "PersistenceSavePre",
				desc = "Close neo-tree before saving",
				callback = function()
					vim.cmd([[Neotree close]])
				end,
			})
			require("neo-tree").setup(opts)
		end,
		keys = {
			{ "<C-n>", "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree" },
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
			messages = {
				enabled = true,
				view = "mini",
				view_error = "mini",
				view_warn = "mini",
				view_history = "mini",
			},
			notify = {
				enabled = true,
				view = "mini",
			},
		},
	},
}
