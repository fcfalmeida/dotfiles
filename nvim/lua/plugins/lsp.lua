return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
	},
	{
		"echasnovski/mini.ai",
		version = false,
		opts = {},
	},
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		config = function()
			vim.lsp.config.clangd = {
				cmd = {
					"clangd",
					"--clang-tidy",
				},
			}

			vim.lsp.config.ts_ls = {
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server"),
							languages = { "vue" },
						},
					},
				},
				filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" },
			}
		end,
		keys = {
			{
				"<leader>sa",
				"<cmd>lua vim.lsp.buf.code_action()<cr>",
				desc = "[S]earch Code [A]ctions for Current Line",
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"clangd",
				"ruff",
				"ty",
				"gopls",
				"docker_language_server",
				"bashls",
				"ts_ls",
				"vue_ls",
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
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
}
