vim.g.firenvim_config = {
  globalSettings = { alt = "all" },
  localSettings = {
    [".*"] = {
      cmdline  = "neovim",
      content  = "text",
      priority = 0,
      selector = "textarea",
      takeover = "never"
    },
  }
}

-- Prevents scrolling when cursor is near the bottom of the text area
if vim.g.started_by_firenvim == true then
  vim.opt.scrolloff = 0
end

vim.api.nvim_create_autocmd({'BufEnter'}, {
  pattern = "localhost_*.txt",
  command = "set filetype=python"
})

