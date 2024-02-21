#!/bin/zsh

# source /opt/miniconda3/etc/profile.d/conda.sh

if [ -z "$(printf $PATH | grep :sourced:)" ] && [ "$DISPLAY" = ":10.0" ]; then
    # zprofile does not get sourced when logging in through an xrdp session (for some reason), even
    # if I try to manually source it in ~/startwm.sh.  This checks for if this is through xrdp (DISPLAY=:10.0)
    # and if the :sourced: flag exists in PATH.
    source ~/.config/zsh/.zprofile
fi

# Below causes discord to not launch
# export LIBVA_DRIVER_NAME=nvidia
# export GBM_BACKEND=nvidia-drm
# export __GLX_VENDOR_LIBRARY_NAME=nvidia

export BROWSER="$(which firefox)"
export EDITOR="$(which nvim)"

export MANPAGER='nvim +Man! -c "ZenMode" -c "map q :qa!<CR>"'
export PAGER=

# export GTK_THEME=gruvbox-dark
export GTK_THEME=Adwaita:dark

# Configuring input method
export QT_IM_MODULE='fcitx'
export SDL_IM_MODULE='fcitx'
export XMODIFIERS='@im=fcitx'

# Defining XDG dirs
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_RUNTIME_DIR="/run/user/$UID"
export XDG_STATE_HOME="$HOME/.local/state"

# Spring cleaning
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export EMACS_INIT_FILE="$XDG_CONFIG_HOME/emacs"
export GIT_CONFIG="$XDG_CONFIG_HOME/git/config"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export SSB_HOME="$XDG_DATA_HOME/zoom"
export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"
export TLDR_CACHE_DIR="$XDG_CACHE_HOME/tldr"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'
export WINEPREFIX="$XDG_DATA_HOME/wine"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XSERVERRC="$XDG_CONFIG_HOME/X11/xserverrc"

export JAVA_HOME="/usr/lib/jvm/default"
export XSECURELOCK_PASSWORD_PROMPT='kaomoji'
export DOOMDIR="$HOME/.config/doom"

export WALLPAPER=~/.config/wallpaper

export SUDO_PROMPT="$(cowsay $(fortune))
Sudo password: "

