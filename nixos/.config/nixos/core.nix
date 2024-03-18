{ config, pkgs, ... }:

let
  nixos-unstable = (import <nixos-unstable> {});
in {
  # Nix settings
  nix = {
    package = pkgs.nixFlakes;
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Files to add to /etc
  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    etc = {
      "zshenv.local".text = ''
          export ZDOTDIR="$HOME/.config/zsh"
      '';
    };
    pathsToLink = [
      "/share"
    ];
  };

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  fonts.packages = with pkgs; [
    # The nerdfonts package does not allow the installation of only the
    # Symbols Nerd Font.  Also, the "mono" (actually double wide)
    # version of this font centers the symbols which is nice.
    nur.repos.bandithedoge.symbols-nerd-font

    hack-font
    fira-code
    inter
  ];

  networking.networkmanager.enable = true;

  # Bluetooth daemon
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Audio daemon
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
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
    man.generateCaches = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # General programs that I like and use
    bluetuith # TUI bluetooth manager
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
    neofetch # Aesthetic sysinfo
    pass-nodmenu # CLI password store (without dmenu dependency)
    pinentry-curses # Terminal-based pinentry program
    python311 # Python
    socat # Interact with sockets
    stow # Simlink farm (used for dotfile management)
    tldr # Brief info about a command
    tmux # Terminal multiplexor
    udisks # Good way of dealing with USBs and similar media
    yazi # Terminal file manager

    # Shell
    starship # Universal shell prompt
    zsh
    zsh-autocomplete
    zsh-autosuggestions
    zsh-nix-shell # Use zsh for nix build shell
    zsh-syntax-highlighting # Shell syntax highlighting

    # Silly programs
    asciiquarium
    bsdgames # Fun collection of command-line games
    neo-cowsay # The cow says moo
    sl # Choo choo

    # Some nix specific stuff
    nil # Nix LSP
    nix-index # See which packages source a file
    nix-output-monitor # Track dependency graph during builds
    nix-prefetch-git # Like nix-prefetch-url, but for git
    nvd # See diffs between builds

    # Pop into an environment abiding by the Filesystem Hierarchy Standard to run
    # applications which do not play nicely with NixOS.
    ( 
    let 
      fhs-run = pkgs.buildFHSUserEnv {
        name = "fhs-run";
        targetPkgs = pkgs: [];
        multiPkgs = pkgs: [ pkgs.dpkg ];
        runScript = pkgs.writeScript "init.sh" ''
          echo "fhs-run" >> $out/etc/hostname # Give shell a hostname
          eval "$@" # Execute whatever arguments
        '';
      };
    in
      fhs-run
    )

    # Defining an environment to run "make" with the proper libraries installed
    # "make", in the main environment, references the script, which envokes the
    # environment, and passes the args to gnumake.
    (
    let
      make-shell = pkgs.buildEnv {
        name = "make-shell";
        paths = with pkgs; [
          # Tools
          gnumake
          pkg-config

          # Libraries
          harfbuzz
          xorg.libX11.dev
          xorg.libXft
          xorg.libXinerama
        ];
      };
    in
      (pkgs.writeScriptBin "make" ''
        #!/usr/bin/env sh
        nix-shell -p ${make-shell} --run "make $*"
      '')
    )
  ];

  nixpkgs.overlays = [
    (self: super: {
      asciiquarium = super.asciiquarium.overrideAttrs (oa: {
        src = pkgs.fetchgit {
          url = "https://github.com/nothub/asciiquarium";
          rev = "204090ff4c97b2e00cd67f26b1a37ca7accd4f95";
          hash = "sha256-0Y0bcsa6GfP/A+gZe6o94WNWfQNHVEtMZfMuvWVBu0c=";
        };
      });
      yazi = nixos-unstable.yazi;
    })
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

