return {
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        config = function()
            vim.g.startuptime_tries = 10
        end,
    },

    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
        keys = {
            {
                "<leader>qs",
                function()
                    require("persistence").load()
                end,
                desc = "Restore Session",
            },
            {
                "<leader>ql",
                function()
                    require("persistence").load({ last = true })
                end,
                desc = "Restore Last Session",
            },
            {
                "<leader>qd",
                function()
                    require("persistence").stop()
                end,
                desc = "Don't Save Current Session",
            },
        },
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = { spelling = true },
        },
        config = function(_, opts)
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup(opts)
        end,
    },

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        cmd = {
            "ToggleTerm",
            "TermExec",
        },
        keys = { [[<A-t>]] },
        opts = {
            open_mapping = [[<A-t>]],
			direction = "float",
			auto_scroll = false
        },
    },

    {
        "tpope/vim-repeat",
        event = "VeryLazy",
    },

    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        ft = "markdown",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    },

    {
        "giusgad/pets.nvim",
        cmd = {
            "PetsNew",
            "PetsNewCustom",
            "PetsList",
            "PetsKill",
            "PetsKillAll",
            "PetsPauseToggle",
            "PetsHideToggle",
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "edluffy/hologram.nvim",
        },
        opts = {},
    },
}
