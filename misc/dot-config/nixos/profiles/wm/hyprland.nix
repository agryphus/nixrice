{ config, pkgs, ... }:

{
  # Or else swaylock will not accept correct password
  security.pam.services.swaylock = {};

  programs = {
    hyprland = { # Dynamic tiling window manager
      enable = true;
      enableNvidiaPatches = true;
      xwayland.enable = true;
    };
    waybar.enable = true; # Status bar
  };

  systemd.user.services = {
    hyprland-autoname-workspaces = {
      description = "Hyprland-autoname-workspaces as systemd service";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      script = "${pkgs.hyprland-autoname-workspaces}/bin/hyprland-autoname-workspaces";
    };
    network-manager-applet = {
      description = "Start the network manager applet";
      wantedBy = [ "default.target" ];
      serviceConfig.Type = "forking";
      serviceConfig.Restart = "always";
      serviceConfig.RestartSec = 2;
      serviceConfig.ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
    };
  };

  environment.systemPackages = with pkgs; [
    blueman # Bluetooth manager
    dunst # Notification daemon
    eww-wayland
    firefox # My browser of choice
    foot # Wayland native terminal
    gobble # Wayland alternative to devour
    grim # Screenshot tool
    grimblast # Allows freezing screen
    hicolor-icon-theme # Icons
    hyprland-autoname-workspaces
    hyprpaper
    kanshi # Autorandr substitute
    libnotify # Send messages to notification daemon
    libreoffice # MSOffice btfo
    networkmanagerapplet # Wifi dropdown menu
    pinentry-rofi # Rofi frontend for pinentry program
    pyprland # Plugin manager for Hyprland
    rofi # Menu prompt program
    rofi-pass # Rofi frontend for password store
    slurp # Screen selection utility
    swaylock # Wayland session locker
    swww # Sets background images
    texlive.combined.scheme-full # LaTeX to create documents
    typst # Cool, minimal LaTeX alternative
    ungoogled-chromium # If I need a special chrome feature
    wayland-utils
    wdisplays # Arnadr substitute
    wl-clipboard # Copy/paste utility
    wlr-randr # Xrandr substitute

    # GTK Themes
    lxappearance-gtk2 # Theme switcher
    gruvbox-dark-gtk

    # Specific versions of packages
    (import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/9957cd48326fe8dbd52fdc50dd2502307f188b0d.tar.gz";
    }) {}).hyprpicker # v0.1.1.  Current verison causes segfault.
  ];

  nixpkgs.overlays = [
    (self: super: {
      grimblast = super.grimblast.override (oa: {
        hyprpicker = (import (builtins.fetchTarball {
          url = "https://github.com/NixOS/nixpkgs/archive/9957cd48326fe8dbd52fdc50dd2502307f188b0d.tar.gz";
        }) {}).hyprpicker; # v0.1.1.  Current verison causes segfault.
      });
    })
  ];
}

