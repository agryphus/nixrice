# ZSH Configurations

unsetopt autocd            # Change directory just by typing its name (hurts performance)
setopt interactivecomments # Allow comments in interactive mode
setopt magicequalsubst     # Enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # Hide error message if there is no match for the pattern
setopt notify              # Report the status of background jobs immediately
setopt numericglobsort     # Sort filenames numerically when it makes sense
setopt promptsubst         # Enable command substitution in prompt
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
unsetopt ksharrays # 0-indexing arrays breaks highlighting

# Start gpg agent
unset SSH_AGENT_PID
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
killall gpg-agent
eval $(gpg-agent --daemon)

export PATH="$PATH:~/.local/share/cargo/bin/"
export PATH="$PATH:$JAVA_HOME/bin/"

if [ ! -z "$(grep nixos /etc/os-release)" ]; then
    # NixOS does not explicitly link usr local bin
    # Yes I know I'm circumventing immutability.
    export PATH=/usr/local/bin:$PATH
fi

export PATH=sourced:$PATH # Flag to prevent setting PATH multiple times
export PATH=~/.local/bin/overrides:$PATH # Overriding /usr/bin/*
export PATH=~/.local/bin:$PATH # Highest precedence to local bin

