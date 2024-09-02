{ config, pkgs, ... }:

let
  # Current verison causes segfault.
  hyprpicker_0_1_1 = (import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/9957cd48326fe8dbd52fdc50dd2502307f188b0d.tar.gz";
  }) {}).hyprpicker; # v0.1.1.
  nixos-unstable = (import <nixos-unstable> {});

  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";

  hyprland_nightly = (import flake-compat {
    # we're not using pkgs.fetchgit as that requires a hash to be provided
    src = builtins.fetchGit {
      url = "https://github.com/hyprwm/Hyprland.git";
      submodules = true;
    };
  }).defaultNix;
in {
  # Trusted Hyprland cache, as to not have to rebuild nightly
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Or else swaylock will not accept correct password
  security.pam.services.swaylock = {};

  programs = {
    hyprland = { # Dynamic tiling window manager
      enable = true;
      xwayland.enable = true;
      # package = nixos-unstable.hyprland;
      package = hyprland_nightly.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    };
  };

  systemd.user.services = {
    hyprland-autoname-workspaces = {
      description = "Hyprland-autoname-workspaces as systemd service";
      after = [ "graphical-session.target" ];
      requires = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      script = "${pkgs.hyprland-autoname-workspaces}/bin/hyprland-autoname-workspaces";
      serviceConfig.Restart = "always";
      serviceConfig.RestartSec = 1;
    };
    network-manager-applet = {
      description = "Start the network manager applet";
      after = [ "graphical-session.target" ];
      requires = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig.Type = "forking";
      serviceConfig.Restart = "always";
      serviceConfig.RestartSec = 1;
      serviceConfig.ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
    };
  };

  environment.systemPackages = with pkgs; [
    ags # GTK shell for status bar and widgets
    blueman # Bluetooth manager
    dunst # Notification daemon
    firefox # My browser of choice
    foot # Wayland native terminal
    fuzzel # Fuzzy finding menuing program
    gobble # Wayland alternative to devour
    grimblast # Allows freezing screen
    grim # Screenshot tool
    hicolor-icon-theme # Icons
    hyprland-autoname-workspaces # Add icons to workspace titles
    hyprpaper
    hyprpicker # Colorpicker utility
    kanshi # Autorandr substitute
    libnotify # Send messages to notification daemon
    libreoffice # MSOffice btfo
    networkmanagerapplet # Wifi dropdown menu
    nsxiv # Image viewer
    nwg-displays
    pinentry-rofi # Rofi frontend for pinentry program
    pyprland # Plugin manager for Hyprland
    rofi # Menu prompt program
    rofi-pass # Rofi frontend for password store
    sassc # SCSS interpreter
    slurp # Screen selection utility
    sassc # Styling language for AGS
    swaylock # Wayland session locker
    swww # Sets background images
    texlive.combined.scheme-full # LaTeX to create documents
    tor-browser # Onion network browser
    typst # Cool, minimal LaTeX alternative
    ungoogled-chromium # If I need a special chrome feature
    waybar # Status bar
    wayland-utils
    wdisplays # Arnadr substitute
    wl-clipboard # Copy/paste utility
    wlr-randr # Xrandr substitute
    xwaylandvideobridge # Allows screensharing from XWayland programs
    xorg.xcursorthemes
    zathura # Minimalist PDF reader

    # GTK Themes
    lxappearance-gtk2 # Theme switcher
    gruvbox-dark-gtk
  ];

  nixpkgs.overlays = [
    (self: super: {
      hyprland-autoname-workspaces = nixos-unstable.hyprland-autoname-workspaces;
      waybar                       = nixos-unstable.waybar;
      typst                        = nixos-unstable.typst;
      hyprpicker = hyprpicker_0_1_1;
      grimblast = super.grimblast.override (o: {
        hyprpicker = hyprpicker_0_1_1;
      });
      ags = pkgs.callPackage "${builtins.fetchGit {
        url = "https://github.com/Aylur/ags.git";
        ref = "main";
      }}/nix" {};
    })
  ];
}

