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
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
eval $(gpg-agent --daemon)

export PATH="$PATH:~/.local/share/cargo/bin/"
export PATH="$PATH:$JAVA_HOME/bin/"

export PATH=~/.local/bin/overrides:$PATH # Overriding /usr/bin/*
export PATH=~/.local/bin:$PATH # Highest precedence to local bin

