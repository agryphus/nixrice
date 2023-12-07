# This configuration is considered to be core to my system.  Each group of features considered not core
# will be found in one of the ./profile 

{ config, pkgs, ... }:

let
    # Change this to your user's name
    HOME = "/home/vince";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./personal.nix

      ./profiles/emacs.nix
      ./profiles/lf.nix
      ./profiles/nvim.nix
      ./profiles/virtualbox.nix
      ./profiles/desktop_wayland.nix
      ./profiles/desktop_x.nix
    ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  environment.sessionVariables = {
    ZDOTDIR = "$HOME/.config/zsh";
  };

  environment.pathsToLink = [
    "/share"
  ];

  system.activationScripts.linkLocalBin.text = ''
    #!/usr/bin/env sh
    # Links things in and out of /usr/local/bin

    # Linking files into /usr/local/bin from main user
    if [ ! -e /usr/local/bin/pinentry-wrapper ] && [ -e /home/vince/.local/bin/pinentry-wrapper ]; then
        ln -s /home/vince/.local/bin/pinentry-wrapper /usr/local/bin/pinentry-wrapper
    fi
  '';

  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

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
  services.syncthing.enable = true;
  services.udisks2.enable = true; # USB Mounting
  # services.printing.enable = true; # CUPS

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    nix-ld.enable = true; # Run unpatched binaries
    zsh.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    mutableUsers = true;
    users.root = {
      # Disables root login, since nothing can hash to "!".  Requires setting mutableUsers to "false",
      # rebuilding, and then setting mutableUsers back to "true".
      hashedPassword = "!";
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # General programs that I like and use
    bluetuith # TUI bluetooth manager
    bear # Generate Clang compilation database
    devour # Opens new program on top of terminal
    distrobox # Easily spin up VMs of other distos
    entr # Hooks for file changes
    git # Imagine not having this
    grc # Generic command output colorizer
    htop-vim # Process monitor, with vim bindings
    imagemagick # Image conversion/processing tool
    jq # Commandline JSON processor
    killall # Easy way to kill a process
    neofetch # Aesthetic sysinfo
    pass-nodmenu # CLI password store (without dmenu dependency)
    pinentry-curses # Terminal-based pinentry program
    python311 # Python
    syncthing # Syncing files between machines
    tldr # Brief info about a command
    tmux # Terminal multiplexor
    udisks # Good way of dealing with USBs and similar media

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
    nix-index
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
    })
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

