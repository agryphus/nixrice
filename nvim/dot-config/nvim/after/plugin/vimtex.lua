vim.cmd([[

syntax enable

let g:maplocalleader=' '
let g:vimtex_view_method='zathura'
let g:tex_flavor='latex' 
let g:vimtex_quickfix_mode=0
set conceallevel=0
let g:tex_conceal='abdmg'
let g:vimtex_view_forward_search_on_start=0 " Weird highlighting otherwise

augroup vimtex_config
  au!
  au User VimtexEventQuit call vimtex#compiler#clean(0)
augroup END

]])



