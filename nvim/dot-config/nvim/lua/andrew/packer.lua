local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
  use "goolord/alpha-nvim"

  use "wbthomason/packer.nvim"

  use "DreamMaoMao/yazi.nvim"

  use "whonore/Coqtail"

  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end
  }

  -- File manager in nvim
  use {
    "ptzz/lf.vim",
    requires = { {"voldikss/vim-floaterm"} },
  }
  vim.cmd("let g:lf_map_keys = 0") -- Need to put here or else doesn't work

  -- Zen mode
  use "folke/zen-mode.nvim"

  -- Find files and strings
  use {
    "nvim-telescope/telescope.nvim", tag = "0.1.4",
    requires = { {"nvim-lua/plenary.nvim"} }
  }

  -- Treesitter
  use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})

  -- Themes
  use "aktersnurra/no-clown-fiesta.nvim"
  use "ellisonleao/gruvbox.nvim"
  use { 'rose-pine/neovim', as = 'rose-pine' }
  use 'Mofiqul/vscode.nvim'

  -- Referencing a hex code highlights it in that color
  use "norcalli/nvim-colorizer.lua"

  -- Relative line numbers disappear when not actively in buffer
  use "jeffkreeftmeijer/vim-numbertoggle"

  -- History visualizer
  use "mbbill/undotree"

  -- See function signatures when typing them
  use "ray-x/lsp_signature.nvim"
  require "lsp_signature".setup({})

  -- Left-side file tree dispaly
  use {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons", -- for file icons
    },
    tag = "nightly" -- optional, updated every week
  }

  -- Shows current mode on bottom of screen
  use "itchyny/lightline.vim"

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},        -- Required

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},             -- Required
      {'hrsh7th/cmp-nvim-lsp'},         -- Required
      {'hrsh7th/cmp-buffer'},           -- Optional
      {'hrsh7th/cmp-path'},             -- Optional
      {'saadparwaiz1/cmp_luasnip'},     -- Optional
      {'hrsh7th/cmp-nvim-lua'},         -- Optional

      -- Snippets
      {'L3MON4D3/LuaSnip'},             -- Required
      {'rafamadriz/friendly-snippets'}, -- Optional
    }
  }

  -- Better diagnostics
  use {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  }

  -- Linting
  use "jose-elias-alvarez/null-ls.nvim"

  -- Git wrapper
  use("tpope/vim-fugitive")

  -- Latex editing in vim
  use "lervag/vimtex"

  -- Auto comment
  use "numToStr/Comment.nvim"

  -- Markdown
  use({
      "agryphus/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- Jupyter notebook integration
  -- use {
  --   "glacambre/firenvim",
  --   run = function() vim.fn["firenvim#install"](0) end
  -- }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

