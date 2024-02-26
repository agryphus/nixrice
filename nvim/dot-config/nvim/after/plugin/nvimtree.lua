-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup()

vim.keymap.set("n", "<leader>pt", vim.cmd.NvimTreeToggle)

-- sets transparent background
vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]

