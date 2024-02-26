require("Comment").setup()

vim.keymap.set(
  "n",
  "<C-_>",
  function() require("Comment.api").toggle.linewise.current() end,
  { noremap = true, silent = true }
)

