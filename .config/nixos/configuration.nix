# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

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

  # networking.hostName = "lappy"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod.enabled = "fcitx5";
  };
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    autorun = false;

    # Configure keymap in X11
    layout = "us";
    xkbOptions = "eurosign:e,caps:escape";

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    displayManager = {
      lightdm.enable = false;
      startx.enable = true;
    };

    windowManager.dwm.enable = true;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vince = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
    ];
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # General programs that I use
    bat # Fancy `cat` which I use for lf
    devour # Opens new program on top of terminal
    dunst # Notification daemon
    fcitx5-configtool # GUI config tool for fcitx5
    fcitx5 # Foreign keyboard switcher
    feh # Image viewer I use for background setting
    git # Imagine not having this
    htop # Process monitor
    killall # Easy way to kill a process
    lf # File explorer
    neofetch # Aesthetic sysinfo
    neovim # Editor
    nsxiv # Image viewer.  Would replace `feh` if it could set backgrounds.
    pass-nodmenu # CLI password store (without dmenu dependency)
    picom # X Compositor
    pinentry-curses # Terminal-based pinentry program
    pinentry-rofi # Rofi frontend for pinentry program
    rofi # Menu prompt program
    rofi-pass # Rofi frontend for password store
    sxhkd # Hotkey daemon
    syncthing # Syncing files between machines
    tmux # Terminal multiplexor
    ueberzugpp # Terminal image overlayer
    zathura # Pdf editor
    zsh # Shell
    zsh-syntax-highlighting # Shell syntax highlighting

    # Suckless utils
    dwm
    dwmblocks
    st

    # Big programs
    firefox
    libreoffice

    # Silly programs
    sl
    asciiquarium
    neo-cowsay

    # Dependencies for other programs (neovim packages, x, etc)
    nodejs
    ripgrep
    gcc
    unzip
    xorg.xauth

    # Some nix specific stuff
    nix-index
    home-manager

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
      fhs-run # Shell abiding by the Filesystem Hierarchy Standard
    )
  ];

  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: {src = /home/vince/.config/dwm;});
    })
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

