vim.api.nvim_create_autocmd("User", {
	pattern = "PersistenceSavePre",
	desc = "Close neo-tree before saving",
	callback = function()
		vim.cmd([[Neotree close]])
	end,
})

local builtin = require("telescope.builtin")

return {
	"folke/which-key.nvim",
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		lazy = false,
		opts = {},
		keys = {
			{ "<C-n>", "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree" },
		},
	},
	{ "nvim-treesitter/nvim-treesitter", branch = "master", lazy = false, build = ":TSUpdate" },
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"neovim/nvim-lspconfig",
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {
			options = { "buffers", "curdir", "tabpages", "winsize" },
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				c = { "clang-format" },
				cpp = { "clang-format" },
			},
		},
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true })
				end,
				desc = "[F]ormat Buffer",
			},
		},
	},
	{
		"nvim-lua/plenary.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>sf", builtin.find_files, desc = "[S]earch [F]iles" },
			{ "<leader>sg", builtin.live_grep, desc = "[S]earch [G]rep" },
			{ "<leader>sw", builtin.grep_string, desc = "[S]earch Current [W]ord" },
			{ "<leader><leader>", builtin.buffers, desc = "Search Buffers" },
		}
	},
}
