vim.g.mapleader = " "

-- opens file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- centers cursor when jumping up and down page
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- easier escape back to normal mode
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")

-- universal find and replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- moving highlighted text 
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- allow for pasting over without losing buffer
vim.keymap.set("x", "<leader>p", "\"_dP")

-- allow copying to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>y", "\"+y")

-- allow deleting to void register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

vim.keymap.set("n", "<leader>tc",
  function ()
    local col = "78"
    print(vim.o.cc)
    if vim.o.cc == col then
      vim.o.cc = ""
    else
      vim.o.cc = col
    end
  end,
  {desc = "Toggle color column"})

-- case insensitive search
vim.keymap.set("n", "<leader>/", "/\\c")
vim.keymap.set("n", "<leader>?", "?\\c")

vim.keymap.set("n", "<leader>hF",
    function()
        local result = vim.treesitter.get_captures_at_cursor(0)
        print(vim.inspect(result))
    end,
    { noremap = true, silent = false, desc = "Describe face" }
)

