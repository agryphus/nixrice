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
export PATH=~/.local/bin/layouts/:$PATH # Overriding /usr/bin/*
export PATH=~/.local/bin/overrides:$PATH # Overriding /usr/bin/*
export PATH=~/.local/bin:$PATH # Highest precedence to local bin

