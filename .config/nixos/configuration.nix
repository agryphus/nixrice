# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./personal.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

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

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      # Have to install fcitx5 through here so that the binary is patched to be able to see the addons.
      # If also installed through system packages, the binary without addonds will take precedence.
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-configtool
        fcitx5-rime
        fcitx5-chinese-addons
      ];
    };
  };

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  fonts.fonts = with pkgs; [
    source-han-sans
    source-han-serif
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];


  # X Server
  services.xserver = {
    enable = true;
    autorun = false;

    autoRepeatDelay = 300;
    autoRepeatInterval = 50;

    # Configure keymap in X11
    layout = "us";
    xkbOptions = "eurosign:e,caps:escape";

    # Touchpad stuff
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };

    displayManager = {
      lightdm.enable = false;
      startx.enable = true;
    };

    windowManager.dwm.enable = true;
  };

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

  # Misc services
  services.udev = {
    # Allows member of the "video" group to change system backlight
    extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video %S%p/brightness", RUN+="${pkgs.coreutils}/bin/chmod g+w %S%p/brightness"
    '';
    path = [ pkgs.coreutils ]; # For chgrp
  };
  services.autorandr.enable = true;
  services.udisks2.enable = true; # USB Mounting
  # services.printing.enable = true; # CUPS

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs = {
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
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
    arandr # Visually move relative positions of monitors
    autorandr # Save and load xrandr profiles
    blueman # Bluetooth manager
    devour # Opens new program on top of terminal
    dunst # Notification daemon
    dwmblocks # Suckless statusbar for DWM
    dwm # Suckless tiling window manager
    feh # Image viewer I use for background setting
    firefox # My browser of choice
    git # Imagine not having this
    htop # Process monitor
    killall # Easy way to kill a process
    libnotify # Send messages to notification daemon
    libreoffice # MSOffice btfo
    maim # Screenshot utility
    neofetch # Aesthetic sysinfo
    pass-nodmenu # CLI password store (without dmenu dependency)
    picom # X Compositor
    pinentry-curses # Terminal-based pinentry program
    pinentry-rofi # Rofi frontend for pinentry program
    python311 # Python
    rofi # Menu prompt program
    rofi-pass # Rofi frontend for password store
    st # Suckless terminal
    sxhkd # Hotkey daemon
    syncthing # Syncing files between machines
    texlive.combined.scheme-full # LaTeX to create documents
    tmux # Terminal multiplexor
    typst # Cool, minimal LaTeX alternative
    udisks # Good way of dealing with USBs and similar media
    ungoogled-chromium # If I need a special chrome feature
    xsecurelock # Session locker
    zsh # Shell
    zsh-syntax-highlighting # Shell syntax highlighting

    # Neovim and neovim accessories
    neovim # Editor
    ###
    nodejs # Used by Mason to pull deps
    ripgrep # Used by telescope
    gcc
    unzip

    # lf and lf accessories
    # There might be some repeats is here from elsewhere in this file, but I simply want to
    # enumerate everything my config of lf depends on.  No, I'm not using home-manager (for now)
    lf # File explorer
    ###
    atool # Provides aunpack, to open archives.  Also can list archive contents.
    bat # A prettified 'cat'
    broot # A slicker fzf
    ffmpegthumbnailer # Get thumbnails of videos
    file # Get information about a specific file
    fzf # Fuzzy finder.  Might fully replace with broot
    mediainfo # Get info about media
    mpv # Audio and video player
    nsxiv # Image viewer
    odt2txt # Convert open documents to text
    perl536Packages.FileMimeInfo # Provides mimeopen, to ask what program to open files in
    poppler_utils # Provides pdftoppm, to turn pdfs into images
    ueberzugpp # Terminal image overlayer
    unrar-wrapper # Extract .rar files
    xclip # Copy file name to clip
    zathura # PDF viewer

    # X accessories
    xorg.xauth
    xclip

    # Silly programs
    asciiquarium # Good to throw on an extra monitor
    bsdgames # Fun collection of command-line games
    neo-cowsay # The cow says moo
    sl # Choo choo

    # Some nix specific stuff
    nix-index
    home-manager

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

  #nixpkgs.overlays = [
  #  (final: prev: {
  #    dwm = prev.dwm.overrideAttrs (old: {src = /home/vince/.config/dwm;});
  #  })
  #];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

