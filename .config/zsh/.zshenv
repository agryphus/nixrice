#!/bin/zsh

source /opt/miniconda3/etc/profile.d/conda.sh

export BROWSER='firefox'
export EDITOR='nvim'
export TERMINAL='st'

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
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/config"
export EMACS_INIT_FILE="$XDG_CONFIG_HOME/emacs"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export GIT_CONFIG="$XDG_CONFIG_HOME/git/config"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XSERVERRC="$XDG_CONFIG_HOME/X11/xserverrc"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export NPM_CONFIG_PREFIX="$XDG_CACHE_HOME/npm"
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'
export JAVA_HOME="/usr/lib/jvm/default/"
export XSECURELOCK_PASSWORD_PROMPT='kaomoji'

export SUDO_PROMPT="
                  ⢀⡔⣻⠁ ⢀⣀⣀⡀        
    ⢀⣾⠳⢶⣦⠤⣀       ⣾⢀⡇⡴⠋⣀⠴⣊⣩⣤⠶⠞⢹⣄   
    ⢸  ⢠⠈⠙⠢⣙⠲⢤⠤⠤ ⠒⠳⡄⣿⢀⠾⠓⢋⠅⠛⠉⠉⠝ ⠼   
    ⢸ ⢰⡀⠁  ⠈⠑⠦⡀    ⠈⠺⢿⣂ ⠉⠐⠲⡤⣄⢉⠝⢸   
    ⢸ ⢀⡹⠆    ⡠⠃       ⠉⠙⠲⣄  ⠙⣷⡄⢸   
    ⢸⡀⠙⠂⢠  ⡠⠊    ⢠    ⠘⠄  ⠑⢦⣔ ⢡⡸   
    ⢀⣧ ⢀⡧⣴⠯⡀     ⡎     ⢸⡠⠔⠈⠁⠙⡗⡤⣷⡀  
    ⡜⠈⠚⠁⣬⠓⠒⢼⠅   ⣠⡇      ⣧   ⡀⢹ ⠸⡄  
   ⡸   ⠘⢸⢀⠐⢃   ⡰⠋⡇   ⢠  ⡿⣆  ⣧⡈⡇⠆⢻  
  ⢰⠃  ⢀⡇⠼⠉ ⢸⡤⠤⣶⡖⠒⠺⢄⡀⢀⠎⡆⣸⣥⠬⠧⢴⣿⠉⠁⠸⡀⣇ 
  ⠇   ⢸   ⣰⠋ ⢸⣿⣿   ⠙⢧⡴⢹⣿⣿   ⠈⣆  ⢧⢹⡄
 ⣸ ⢠  ⢸⡀  ⢻⡀ ⢸⣿⣿    ⡼⣇⢸⣿⣿   ⢀⠏  ⢸ ⠇
 ⠓⠈⢃   ⡇   ⣗⠦⣀⣿⡇ ⣀⠤⠊ ⠈⠺⢿⣃⣀⠤⠔⢸   ⣼⠑⢼
   ⢸⡀⣀⣾⣷⡀ ⢸⣯⣦⡀   ⢇⣀⣀⠐⠦⣀⠘  ⢀⣰⣿⣄  ⡟  
    ⠛⠁⣿⣿⣧ ⣿⣿⣿⣿⣦⣀       ⣀⣠⣴⣿⣿⡿⠈⠢⣼⡇  
      ⠈⠁⠈⠻⠈⢻⡿⠉⣿⠿⠛⡇⠒⠒⢲⠺⢿⣿⣿⠉⠻⡿⠁  ⠈⠁  
⢀⠤⠒⠦⡀       ⢀⠞⠉⠆  ⠉⠉⠉  ⡝⣍          
⡎   ⡇      ⡰⠋  ⢸       ⢡⠈⢦         
⡇  ⠸⠁    ⢀⠜⠁   ⡸       ⠘⡄⠈⢳⡀       
⡇  ⢠    ⠠⣯⣀   ⡰⡇        ⢣ ⢀⡦⠤⢄⡀    
⢱⡀ ⠈⠳⢤⣠⠖⠋⠛⠛⢷⣄⢠⣷⠁        ⠘⡾⢳⠃  ⠘⢇   
 ⠙⢦⡀ ⢠⠁     ⠙⣿⣏⣀       ⣀⣴⣧⡃    ⣸   
   ⠈⠉⢺⣄      ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣗⣤⣀⣠⡾⠃   
      ⠣⢅⡤⣀⣀⣠⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠉⠉⠉     
        ⠉⠉⠉⠁ ⠉⣿⣿⣿⣿⣿⡿⠻⣿⣿⣿⣿⠛⠉        
             ⣸⣿⣿⣿    ⣿⣿⣿⡿          
            ⣴⣿⣿⣿⣟  ⢠⣿⣿⣿⣿⣧          
           ⢰⣿⣿⣿⣿⣿  ⢸⣿⣿⣿⣿⣿          
           ⢸⣿⣿⣿⣿⡏  ⢸⣿⣿⣿⣿⣿⡀         
          ⢠⣿⣿⣿⣿⣿   ⢺⣿⣿⣿⣿⣿⣿⣷        
          ⣿⣿⣿⣿⣿⣿    ⠈⠉⠻⣿⣿⣿⠟        
          ⠘⢿⣿⣿⣿⠏ Dori dori"

