
syn include @Vim $VIMRUNTIME/syntax/vim.vim
syn region embedvim matchgroup=luaEmbedError start="vim\.api\.nvim_command(\[\[" end="\]\])" keepend contains=@Vim
syn region embedvim matchgroup=luaEmbedError start="vim\.api\.nvim_command \[\[" end="\]\]" keepend contains=@Vim
syn region embedvim matchgroup=luaEmbedError start="vim\.api\.nvim_exec(\[\[" end="\]\])" keepend contains=@Vim
syn region embedvim matchgroup=luaEmbedError start="vim\.api\.nvim_exec \[\[" end="\]\]" keepend contains=@Vim
syn region embedvim matchgroup=luaEmbedError start="vim\.cmd \[\[" end="\]\]" keepend contains=@Vim
syn region embedvim matchgroup=luaEmbedError start="vim\.cmd(\[\[" end="\]\])" keepend contains=@Vim
syn region embedvim matchgroup=luaEmbedError start="vim\.cmd \"" end="\"" keepend contains=@Vim
syn region embedvim matchgroup=luaEmbedError start="vim\.cmd(\"" end="\")" keepend contains=@Vim
syn region embedvim matchgroup=luaEmbedError start="vim\.cmd '" end="'" keepend contains=@Vim
syn region embedvim matchgroup=luaEmbedError start="vim\.cmd('" end="')" keepend contains=@Vim

let b:current_syntax = 'lua'

