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
		"akinsho/bufferline.nvim",
        enabled = false,
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
	},
}
