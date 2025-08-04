local function search_files()
	return require("telescope.builtin").find_files()
end

local function search_grep()
	return require("telescope.builtin").live_grep()
end

local function search_word()
	return require("telescope.builtin").grep_string()
end

local function search_buffers()
	return require("telescope.builtin").buffers()
end

return {
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
		{ "<leader>sf", search_files, desc = "[S]earch [F]iles" },
		{ "<leader>sg", search_grep, desc = "[S]earch [G]rep" },
		{ "<leader>sw", search_word, desc = "[S]earch Current [W]ord" },
		{ "<leader><leader>", search_buffers, desc = "Search Buffers" },
	},
}
