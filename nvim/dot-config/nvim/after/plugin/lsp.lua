-- LANGUAGE SERVERS
local lsp_zero = require('lsp-zero')
local lspconfig = require("lspconfig")
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

-- LUA
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        -- Making sure that lua recognizes the global variable 'vim'
        globals = { 'vim', 'xplr' },
      },
    },
  },
})

-- RUST
-- Must run `rustup default stable` and then `rustup component add rust-analyzer`
-- upon first install
lspconfig.rust_analyzer.setup({})

lspconfig.clangd.setup({
  capabilities = lsp_capabilities,
})

-- AUTOCOMPLETION

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  sources = {
    { name = "luasnip", option = { show_autosnippets = true } },
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "path" }, -- Auto complete paths
  },
  mapping = {
    -- Navigate between completion item
    ['<M-k>'] = cmp.mapping.select_prev_item(),
    ['<M-j>'] = cmp.mapping.select_next_item(),

    -- toggle completion
    ['<M-u>'] = cmp_action.toggle_completion(),

    -- navigate between snippet placeholder
    ['<C-a>'] = cmp_action.luasnip_jump_backward(),
    ['<C-d>'] = cmp_action.luasnip_jump_forward(),

    -- Confirm item
    ['<Tab>'] = cmp.mapping.confirm({select = true}),
  }
})

-- DIAGNOSTICS

-- Show all diagnostics on current line in floating window
vim.api.nvim_set_keymap(
  'n', 'gl', ':lua vim.diagnostic.open_float()<CR>',
  { noremap = true, silent = true }
)

