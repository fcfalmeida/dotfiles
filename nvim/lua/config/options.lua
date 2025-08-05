vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.hlsearch = true -- Set highlight on search
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.tabstop = 4 -- Number of spaces a tab counts for
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.swapfile = false

vim.diagnostic.config({
	virtual_text = true, -- Show inline diagnostic messages
	underline = true, -- Underline problematic code
	update_in_insert = false, -- Avoid updating diagnostics in insert mode
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
})
