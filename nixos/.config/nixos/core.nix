{ config, pkgs, ... }:

let
  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
in {
  # Nix settings
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    # I do not use flakes personally, but being able to run other
    # people's flakes is convenient.
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # Files to add to /etc
  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    etc = {
      "profile.local".text = ''
          export FOO=bar
      '';
      "zshenv.local".text = ''
          export ZDOTDIR="$HOME/.config/zsh"
      '';
    };
    pathsToLink = [
      "/share"
    ];
  };

  networking.networkmanager.enable = true;

  i18n.defaultLocale  = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT    = "en_US.UTF-8";
    LC_MONETARY       = "en_US.UTF-8";
    LC_NAME           = "en_US.UTF-8";
    LC_NUMERIC        = "en_US.UTF-8";
    LC_PAPER          = "en_US.UTF-8";
    LC_TELEPHONE      = "en_US.UTF-8";
    LC_TIME           = "en_US.UTF-8";
  };

  fonts.packages = with pkgs; [
    # The nerdfonts package does not allow the installation of only the
    # Symbols Nerd Font.  Also, the "mono" (actually double wide)
    # version of this font centers the symbols which is nice.
    nur.repos.bandithedoge.symbols-nerd-font

    fira-code
    nerd-fonts.fira-code
    font-awesome
    hack-font
    inter
    libertine
    roboto
    source-sans-pro
  ];

  # Bluetooth daemon
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Audio daemon
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Udev service
  services.udev = {
    # Allows member of the "video" group to change system backlight
    extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video %S%p/brightness", RUN+="${pkgs.coreutils}/bin/chmod g+w %S%p/brightness"
    '';
    path = [ pkgs.coreutils ]; # For chgrp
  };

  # Misc services
  services.udisks2.enable = true; # USB Mounting
  # services.printing.enable = true; # CUPS

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    nix-ld = {
      # Run unpatched binaries.
      enable = true;
      libraries = with pkgs; [
        # Add missing dynamic libraries for unpackages programs here
      ];
    };
    zsh.enable = true;
    command-not-found.enable = true;
  };

  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    mutableUsers = true;
    users.root = {
      # Disables root login, since nothing can hash to "!".  Requires setting mutableUsers to "false",
      # rebuilding, and then setting mutableUsers back to "true".
      hashedPassword = "!";
    };
  };

  documentation = {
    # Pull in extra documentation/manpages
    dev.enable = true;

    # Allow whatis, apropos, and man -k to work, but breaks mandb
    man.cache.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # General programs that I like and use
    bluetui # TUI bluetooth manager
    bear # Generate Clang compilation database
    devour # Opens new program on top of terminal
    dash # Fast, posix compliant shell
    distrobox # Easily spin up VMs of other distos
    docker # Containerization
    entr # Hooks for file changes
    expect # Provides `unbuffer`
    ffmpeg
    git # Imagine not having this
    grc # Generic command output colorizer
    htop-vim # Process monitor, with vim bindings
    imagemagick # Image conversion/processing tool
    jq # Commandline JSON processor
    killall # Easy way to kill a process
    man-pages # Documentation
    man-pages-posix # Documentation
    openconnect # Connect to VPNs
    p7zip # Open 7z files
    pass-nodmenu # CLI password store (without dmenu dependency)
    pinentry-curses # Terminal-based pinentry program
    socat # Interact with sockets
    stow # Simlink farm (used for dotfile management)
    tldr # Brief info about a command
    tmux # Terminal multiplexor
    udisks # Good way of dealing with USBs and similar media
    unrar-free # Open .rar files
    wget # Similar to curl
    yazi # Terminal file manager

    # Shell
    starship # Universal shell prompt
    zsh
    zsh-autocomplete
    zsh-autosuggestions
    zsh-nix-shell # Use zsh for nix build shell
    zsh-syntax-highlighting # Shell syntax highlighting

    # Silly programs
    asciiquarium-transparent # ASCII fish tank animation
    bsdgames # Fun collection of command-line games
    neo-cowsay # The cow says moo
    sl # Choo choo

    # Some nix specific stuff
    nil # Nix LSP
    nix-index # See which packages source a file
    nix-output-monitor # Track dependency graph during builds
    nix-prefetch-git # Like nix-prefetch-url, but for git
    nvd # See diffs between builds

    # Custom overlays.  See below for explanations
    fhs-run
    python-common
  ];

  
  nixpkgs.overlays = [
    (self: super: {
      # Pop into an environment abiding by the Filesystem Hierarchy Standard 
      # to run applications which do not play nicely with NixOS.
      fhs-run = pkgs.buildFHSEnv {
        name = "fhs-run";
        targetPkgs = pkgs: [];
        multiPkgs = pkgs: [ pkgs.dpkg ];
        runScript = pkgs.writeScript "init.sh" ''
          echo "fhs-run" >> $out/etc/hostname # Give shell a hostname
          eval "$@" # Execute whatever arguments
        '';
      };

      # When evoking the command `python` from outside a shell, it runs the
      # commands inside a nix shell containing common python packages that I
      # always want to be available.
      python-common = pkgs.python3.withPackages (ps: with ps; [
        requests
      ]);
    })
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };
}

