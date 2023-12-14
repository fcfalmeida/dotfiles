local format = function()
    local buf = vim.api.nvim_get_current_buf()
    local ft = vim.bo[buf].filetype
    local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

    vim.lsp.buf.format({
        async = true,
        bufnr = buf,
        filter = function(client)
            if have_nls then
                return client.name == "null-ls"
            end
            return client.name ~= "null-ls"
        end,
    })
end

local on_attach = function(_, bufnr)
    local map = function(mode, keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
    end
    local nmap = function(...)
        return map("n", ...)
    end
    local vmap = function(...)
        return map("v", ...)
    end

    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    nmap("gd", "<cmd>Telescope lsp_definitions<cr>", "[G]oto [D]efinition")
    nmap("gr", "<cmd>Telescope lsp_references<cr>", "[G]oto [R]eferences")
    nmap("gI", "<cmd>Telescope lsp_implementations<cr>", "[G]oto [I]mplementation")
    nmap("gt", "<cmd>Telescope lsp_type_definitions<cr>", "[G]oto [T]ype Definition")
    nmap("<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", "[D]ocument [S]ymbols")
    nmap("<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "[W]orkspace [S]ymbols")

    -- See `:help K` for why this keymap
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")

    nmap("<space>f", format, "[F]ormat Buffer")
    vmap("<space>f", format, "[F]ormat Range")
end

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "folke/neodev.nvim",
        },
        opts = {
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = { spacing = 4, prefix = "●" },
                severity_sort = true,
            },
            servers = {
                bashls = {},
                pyright = {},
                yamlls = {},
                eslint = {},
                tsserver = {},
                jsonls = {},
                cmake = {},
                clangd = {},
                dockerls = {},
                -- gopls = {},
                rust_analyzer = {},
                lua_ls = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            },
        },
        config = function(_, opts)
            for name, icon in pairs(require("user.icons").diagnostics) do
                name = "DiagnosticSign" .. name
                vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
            end
            vim.diagnostic.config(opts.diagnostics)

            -- Setup neovim lua configuration
            require("neodev").setup()
            --
            -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            -- Setup mason so it can manage external tooling
            require("mason").setup()

            -- Ensure the servers above are installed
            local mason_lspconfig = require("mason-lspconfig")

            mason_lspconfig.setup({
                ensure_installed = vim.tbl_keys(opts.servers),
            })

            mason_lspconfig.setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = opts.servers[server_name],
                    })
                end,
            })

            require("lspconfig").gdscript.setup({})
        end,
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "williamboman/mason.nvim",
        },
        opts = function()
            local null_ls = require("null-ls")
            return {
                sources = {
                    null_ls.builtins.formatting.autopep8,
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.yamlfmt,
                    null_ls.builtins.formatting.shfmt,
                    null_ls.builtins.formatting.xmlformat,
                },
            }
        end,
    },

    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {
            ensure_installed = {
                -- Formatter
                "autopep8",
                "cmakelang",
                "stylua",
                "yamlfmt",
                "shfmt",
                "xmlformatter",
                -- Linter
                "shellcheck",
                -- DAP
                "cpptools",
                "debugpy",
                -- "delve",
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            for _, tool in ipairs(opts.ensure_installed) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end,
    },
}
