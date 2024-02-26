local palette = {
  none = "NONE",
  fg = "#E1E1E1",
  bg = "#151515",
  alt_bg = "#171717",
  accent = "#202020",
  white = "#E1E1E1",
  gray = "#373737",
  medium_gray = "#727272",
  light_gray = "#AFAFAF",
  blue = "#BAD7FF",
  gray_blue = "#7E97AB",
  medium_gray_blue = "#A2B5C1",
  cyan = "#88afa2",
  red = "#b46958",
  green = "#90A959",
  yellow = "#F4BF75",
  orange = "#FFA557",
  purple = "#AA749F",
  magenta = "#AA759F",
  cursor_fg = "#151515",
  cursor_bg = "#D0D0D0",
  sign_add = "#586935",
  sign_change = "#51657B",
  sign_delete = "#984936",
  error = "#984936",
  warning = "#ab8550",
  info = "#ab8550",
  hint = "#576f82",
  neogit_light_green = "#2A2E19",
  neogit_blue = "#1B1F27",
  neogit_green = "#212513",
  neogit_light_red = "#402020",
  neogit_red = "#351D1D",
}

require("no-clown-fiesta").setup({
  transparent = true,
})

require('rose-pine').setup({
	--- @usage 'auto'|'main'|'moon'|'dawn'
	variant = 'auto',
	--- @usage 'main'|'moon'|'dawn'
	dark_variant = 'main',
	bold_vert_split = false,
	dim_nc_background = false,
	disable_background = true,
	disable_float_background = false,
	disable_italics = true,

	--- @usage string hex value or named color from rosepinetheme.com/palette
	groups = {
		background = 'base',
		background_nc = '_experimental_nc',
		panel = 'surface',
		panel_nc = 'base',
		border = 'highlight_med',
		comment = 'muted',
		link = 'iris',
		punctuation = 'subtle',

		error = 'love',
		hint = 'iris',
		info = 'foam',
		warn = 'gold',

		headings = {
			h1 = 'iris',
			h2 = 'foam',
			h3 = 'rose',
			h4 = 'gold',
			h5 = 'pine',
			h6 = 'foam',
		}
		-- or set all headings at once
		-- headings = 'subtle'
	},

	-- Change specific vim highlight groups
	-- https://github.com/rose-pine/neovim/wiki/Recipes
	highlight_groups = {
		ColorColumn = { bg = 'rose' },

		-- Blend colours against the "base" background
		CursorLine = { bg = 'foam', blend = 10 },
		StatusLine = { fg = 'love', bg = 'love', blend = 10 },

		-- By default each group adds to the existing config.
		-- If you only want to set what is written in this config exactly,
		-- you can set the inherit option:
		Search = { bg = 'gold', inherit = false },
	}
})

require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = true,
})

local c = require('vscode.colors').get_colors()
require('vscode').setup({
    -- Alternatively set style in setup
    -- style = 'light'

    -- Enable transparent background
    transparent = true,

    -- Enable italic comment
    italic_comments = true,

    -- Disable nvim-tree background color
    disable_nvimtree_bg = true,

    -- Override colors (see ./lua/vscode/colors.lua)
    color_overrides = {
        -- vscLineNumber = '#FFFFFF',
    },

    -- Override highlight groups (see ./lua/vscode/theme.lua)
    group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
        Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
    }
})

vim.cmd[[
let s:base03  = [ '#151513', 233 ]
let s:base02  = [ '#202020', 236 ]
let s:base01  = [ '#373737', 239 ]
let s:base00  = [ '#727272', 242  ]
let s:base0   = [ '#808070', 244 ]
let s:base1   = [ '#949484', 246 ]
let s:base2   = [ '#a8a897', 248 ]
let s:base3   = [ '#E1E1E1', 253 ]
let s:yellow  = [ '#F4BF75', 3 ]
let s:orange  = [ '#FFA557', 216 ]
let s:red     = [ '#B46958', 131 ]
let s:purple  = [ '#AA749F', 181 ]
let s:blue    = [ '#7E97AB', 109 ]
let s:cyan    = [ '#BAD7FF', 23 ]
let s:green   = [ '#90A959', 108 ]
let s:white   = [ '#AFAFAF', 252 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left     = [ [ s:base02, s:green ],   [ s:base3,  s:base01 ] ]
let s:p.normal.right    = [ [ s:base02, s:base1 ],   [ s:base2,  s:base01 ] ]
let s:p.inactive.right  = [ [ s:base02, s:base00 ],  [ s:base0,  s:base02 ] ]
let s:p.inactive.left   = [ [ s:base0,  s:base02 ],  [ s:base00, s:base02 ] ]
let s:p.insert.left     = [ [ s:base02, s:blue ],    [ s:base3,  s:base01 ] ]
let s:p.replace.left    = [ [ s:base02, s:purple ],  [ s:base3,  s:base01 ] ]
let s:p.visual.left     = [ [ s:base02, s:red ],     [ s:base3,  s:base01 ] ]
let s:p.normal.middle   = [ [ s:base0,  s:base02 ] ]
let s:p.inactive.middle = [ [ s:base00, s:base02 ] ]
let s:p.tabline.left    = [ [ s:base3,  s:base00 ] ]
let s:p.tabline.tabsel  = [ [ s:base3,  s:base02 ] ]
let s:p.tabline.middle  = [ [ s:base01, s:base1 ] ]
let s:p.tabline.right   = copy(s:p.normal.right)
let s:p.normal.error    = [ [ s:red,    s:base02 ] ]
let s:p.normal.warning  = [ [ s:yellow, s:base01 ] ]

let g:lightline#colorscheme#mycolors#palette = lightline#colorscheme#flatten(s:p)
let g:lightline = {
      \ 'colorscheme': 'mycolors',
      \ }

" Don't need to see mode if lightline is installed
set noshowmode
]]

vim.cmd[[colorscheme no-clown-fiesta]]

-- My own color overrides
local hl = vim.api.nvim_set_hl
hl(0, 'TSConstant',           { fg = palette.yellow })
hl(0, 'EndOfBuffer',          { fg = palette.medium_gray })
hl(0, 'ErrorMsg',             { fg = palette.yellow })
hl(0, 'LineNr',               { fg = palette.medium_gray })
hl(0, 'MasonNormal',          { bg = palette.gray })
hl(0, 'NvimTreeCursorLine',   { fg = palette.yellow })
hl(0, 'NvimTreeEndOfBuffer',  { fg = palette.medium_gray })
hl(0, 'NvimTreeIndentMarker', { fg = palette.medium_gray })
hl(0, 'NvimTreeFolderIcon',   { fg = palette.yellow })
hl(0, 'WhichKeyFloat',        { bg = nil })
hl(0, 'WhichKeyDesc',         { link = "function" })
hl(0, 'WhichKey',             { fg = palette.medium_gray_blue })
hl(0, 'WhichKeyGroup',        { fg = palette.gray_blue, bold = true })

