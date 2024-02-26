local builtin = require("telescope.builtin")

require("telescope").setup{
  defaults = {
    file_ignore_patterns = { ".git\\", ".pyc", ".mypy_cache\\", "node_modules\\", ".svg"  }
  }
}

local wk = require("which-key")

-- <leader> p
wk.register({p = { name = "project" }, prefix = "<leader>"})
vim.keymap.set("n", "<leader>pf", builtin.find_files, {desc = "Project find"})
vim.keymap.set("n", "<leader>ps", function ()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
  end                                               , {desc = "Project search"})

-- <leader> f
wk.register({f = { name = "find" }, prefix = "<leader>"})
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recent" })

-- <leader> h
wk.register({h = { name = "help" }, prefix = "<leader>"})
vim.keymap.set("n", "<leader>ht", builtin.colorscheme, { desc = "Load theme" })
vim.keymap.set("n", "<leader>hf", builtin.commands   , { desc = "Describe function" })
vim.keymap.set("n", "<leader>hk", builtin.keymaps    , { desc = "Describe key" })
vim.keymap.set("n", "<leader>hv", builtin.vim_options, { desc = "Describe key" })
vim.keymap.set("n", "<leader>hh", builtin.help_tags  , { desc = "Search local wiki" })

