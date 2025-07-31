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
		opts = {
			filesystem = {
				follow_current_file = {
					enabled = true,
				},
			},
		},
		config = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "PersistenceSavePre",
				desc = "Close neo-tree before saving",
				callback = function()
					vim.cmd([[Neotree close]])
				end,
			})
		end,
		keys = {
			{ "<C-n>", "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree" },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		opts = {
			highlight = { enable = true },
		},
	},
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
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
		opts = {
			defaults = {
				mappings = {
					i = {
						["<C-Down>"] = "cycle_history_next",
						["<C-Up>"] = "cycle_history_prev",
						["<C-k>"] = "move_selection_previous",
						["<C-j>"] = "move_selection_next",
						["<C-h>"] = "which_key",
						["<esc>"] = "close",
					},
				},
			},
		},
		keys = {
			{ "gd", "<cmd>Telescope lsp_definitions<cr>", "[G]oto [D]efinition" },
			{ "gr", "<cmd>Telescope lsp_references<cr>", "[G]oto [R]eferences" },
			{ "gi", "<cmd>Telescope lsp_implementations<cr>", "[G]oto [I]mplementation" },
			{ "<leader>sf", builtin.find_files, desc = "[S]earch [F]iles" },
			{ "<leader>sg", builtin.live_grep, desc = "[S]earch [G]rep" },
			{ "<leader>sw", builtin.grep_string, desc = "[S]earch Current [W]ord" },
			{ "<leader><leader>", builtin.buffers, desc = "Search Buffers" },
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets" },

		version = "1.*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "default",
				["<Tab>"] = { "select_next", "fallback" },
				["<CR>"] = { "accept", "fallback" },
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				documentation = { auto_show = false },
				list = {
					selection = { preselect = true, auto_insert = true },
				},
				accept = {
					auto_brackets = { enabled = true },
				},
			},
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"akinsho/bufferline.nvim",
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
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		opts = {
			symbol = "│",
			options = {
				try_as_border = true,
			},
		},
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "neo-tree", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
	{
		"echasnovski/mini.surround",
		version = false,
		opts = {},
	},
}
