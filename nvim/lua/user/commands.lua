-- Custom searches ---------------------------------------------------------------------------------
vim.api.nvim_create_user_command("SearchFiles", function(opts)
    require("telescope.builtin").find_files({
        cwd = opts.args,
        prompt_title = "[" .. opts.args .. "] Search Files",
    })
end, { nargs = "?", bang = true })

vim.api.nvim_create_user_command("SearchGrep", function(opts)
    require("telescope.builtin").live_grep({
        cwd = opts.args,
        prompt_title = "[" .. opts.args .. "] Search Grep",
    })
end, { nargs = "?", bang = true })

-- Genisys Commands --------------------------------------------------------------------------------
vim.api.nvim_create_user_command("GenisysCompile", function(opts)
    vim.cmd("wa")
    vim.cmd(string.format('TermExec cmd="cimmerian build --test --coverage --no-pch %s"', opts.args))
end, { nargs = "*", bang = true })

vim.api.nvim_create_user_command("GenisysTest", function(opts)
    vim.cmd("wa")
    vim.cmd(string.format('TermExec cmd="cimmerian test %s"', opts.args))
end, { nargs = "*", bang = true })

vim.api.nvim_create_user_command("GenisysCompileTest", function(opts)
    vim.cmd("wa")
    vim.cmd(string.format('TermExec cmd="cimmerian build --test --coverage --no-pch && cimmerian test %s"', opts.args))
end, { nargs = "*", bang = true })
