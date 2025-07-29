vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.hlsearch = true -- Set highlight on search
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.tabstop = 4 -- Number of spaces a tab counts for
vim.opt.shiftwidth = 4
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.diagnostic.config({
  virtual_text = true, -- Show inline diagnostic messages
  signs = true,        -- Show signs in the gutter
  underline = true,    -- Underline problematic code
  update_in_insert = false, -- Avoid updating diagnostics in insert mode
  severity_sort = true,
})

local signs = {
  Error = " ",
  Warn  = " ",
  Hint  = " ",
  Info  = " ",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
