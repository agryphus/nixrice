#!/bin/zsh

# source /opt/miniconda3/etc/profile.d/conda.sh

if [ -z "$(printf $PATH | grep :sourced:)" ] && [ "$DISPLAY" = ":10.0" ]; then
    # zprofile does not get sourced when logging in through an xrdp session (for some reason), even
    # if I try to manually source it in ~/startwm.sh.  This checks for if this is through xrdp (DISPLAY=:10.0)
    # and if the :sourced: flag exists in PATH.
    source ~/.config/zsh/.zprofile
fi

export BROWSER="$(which firefox)"
export EDITOR="$(which nvim)"
export TERMINAL="$(which st)"

# Configuring input method
export GTK_IM_MODULE='fcitx'
export QT_IM_MODULE='fcitx'
export SDL_IM_MODULE='fcitx'
export XMODIFIERS='@im=fcitx'

# Spring cleaning
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export EMACS_INIT_FILE="$XDG_CONFIG_HOME/emacs"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export GIT_CONFIG="$XDG_CONFIG_HOME/git/config"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XSERVERRC="$XDG_CONFIG_HOME/X11/xserverrc"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export SSB_HOME="$XDG_DATA_HOME/zoom"
export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"

export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'
export JAVA_HOME="/usr/lib/jvm/default/"
export XSECURELOCK_PASSWORD_PROMPT='kaomoji'

export WALLPAPER=~/.config/wallpaper

export SUDO_PROMPT="$(cowsay --random $(fortune))
Sudo password: "

