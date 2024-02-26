vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.linebreak = true

local autocmd = vim.api.nvim_create_autocmd
autocmd("bufenter", {
  pattern = "*",
  callback = function()
    if vim.bo.ft ~= "terminal" then
      vim.opt.laststatus = 2
    else
      vim.opt.laststatus = 0
    end
  end,
})

-- Only search with case if capital letter is typed
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = true

vim.opt.splitbelow = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "auto"

vim.o.shell = "zsh"

-- Do not map q to :q in man mode
vim.g.no_man_maps = true;

-- Local settings for when in :terminal mode
-- I don't believe this functionality has been ported to lua.
vim.cmd([[
function! TerminalSettings()
  setlocal nonumber norelativenumber
  setlocal scrolloff=0
endfunction
autocmd TermOpen * call TerminalSettings()
]])

