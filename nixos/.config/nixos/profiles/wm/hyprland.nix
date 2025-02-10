{ config, pkgs, ... }:

let
  # Current verison causes segfault.
  nixos-unstable = (import <nixos-unstable> {});
  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
  hyprland_nightly = (import flake-compat {
    src = builtins.fetchGit {
      ref = "main";
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
      # package = hyprland_nightly.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    };
    nm-applet.enable = true;
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
    # network-manager-applet = {
    #   description = "Start the network manager applet";
    #   after = [ "graphical-session.target" ];
    #   requires = [ "graphical-session.target" ];
    #   wantedBy = [ "graphical-session.target" ];
    #   serviceConfig.Type = "forking";
    #   serviceConfig.Restart = "always";
    #   serviceConfig.RestartSec = 1;
    #   serviceConfig.ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
    # };
  };

  environment.systemPackages = with pkgs; [
    blueman # Bluetooth manager
    dunst # Notification daemon
    firefox # My browser of choice
    foot # Wayland native terminal
    fuzzel # Fuzzy finding menuing program
    gobble # Wayland alternative to devour
    grimblast # Allows freezing screen
    grim # Screenshot tool
    hicolor-icon-theme # Icons
    hypridle # Do commands upon user idle
    hyprland-autoname-workspaces # Add icons to workspace titles
    hyprlock # Screen locking utility
    hyprpaper
    hyprpicker # Colorpicker utility
    kanshi # Autorandr substitute
    libnotify # Send messages to notification daemon
    libreoffice # MSOffice btfo
    # networkmanagerapplet # Wifi dropdown menu
    networkmanager_dmenu # Manage wifi with dmenu
    nsxiv # Image viewer
    nwg-displays
    pinentry-rofi # Rofi frontend for pinentry program
    pyprland # Plugin manager for Hyprland
    rofi # Menu prompt program
    rofi-pass # Rofi frontend for password store
    sassc # SCSS interpreter
    slurp # Screen selection utility
    st
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
    zen-browser

    # GTK Themes
    lxappearance-gtk2 # Theme switcher
    gruvbox-dark-gtk
  ];

  nixpkgs.overlays = [
    (final: prev: {
      hyprland-autoname-workspaces = nixos-unstable.hyprland-autoname-workspaces;
      waybar                       = nixos-unstable.waybar;
      typst                        = nixos-unstable.typst;
      # typst = (import flake-compat {
      #   src = builtins.fetchGit {
      #     url = "https://github.com/typst/typst.git";
      #   };
      # }).outputs.packages.${pkgs.stdenv.hostPlatform.system}.default;
      zen-browser = (import flake-compat {
        src = builtins.fetchGit {
          url = "https://github.com/0xc000022070/zen-browser-flake.git";
        };
      }).outputs.packages.${pkgs.stdenv.hostPlatform.system}.default;
      st = prev.st.overrideAttrs (o: {
        src = /home/vince/.config/st;
        buildInputs = o.buildInputs ++ (with pkgs; [
          # Extra libraries needed to build patches
          harfbuzz
          imlib2
        ]);
      });
    })
  ];
}

