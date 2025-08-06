return {
	"folke/which-key.nvim",
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {
			options = { "buffers", "curdir", "tabpages", "winsize" },
		},
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bufdelete = { enabled = true },
		},
        keys = {
            { "<S-w>", function() Snacks.bufdelete.delete() end, desc = "Delete current buffer" }
        }
	},
}
