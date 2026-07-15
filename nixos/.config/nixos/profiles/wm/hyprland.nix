{ config, pkgs, ... }:

let
  # Current verison causes segfault.
  nixos-unstable = (import <nixos-unstable> {});
  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
  hyprland_nightly = (import flake-compat {
    src = builtins.fetchTarball "https://github.com/hyprwm/Hyprland/archive/main.tar.gz";
  }).defaultNix;
in {
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Or else swaylock will not accept correct password
  security.pam.services.swaylock = {};

  services.keyd.enable = true;
  services.keyd.keyboards = {
    default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "overload(control, esc)";
          esc = "capslock";
        };
      };
    };
  };

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  programs = {
    hyprland = { # Dynamic tiling window manager
      enable = true;
      xwayland.enable = true;
    };

    dconf = {
      enable = true;
      profiles.gdm.databases = [{
        settings = {
          # set dark theme for gtk 4
          "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
        };
      }];
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
  };

  environment.variables.GSETTINGS_SCHEMA_DIR =
    let
      paths = [
        "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas/"
        "${pkgs.bottles-unwrapped}/share/gsettings-schemas/${pkgs.bottles-unwrapped.name}/glib-2.0/schemas/"
      ];
    in
      builtins.concatStringsSep ":" paths;

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    adwaita-qt
    blueman # Bluetooth manager
    dunst # Notification daemon
    firefox # My browser of choice
    foot # Wayland native terminal
    fuzzel # Fuzzy finding menuing program
    glib
    gnome-themes-extra
    gobble # Wayland alternative to devour
    grimblast # Allows freezing screen
    grim # Screenshot tool
    hicolor-icon-theme # Icons
    hypridle # Do commands upon user idle
    hyprland-autoname-workspaces # Add icons to workspace titles
    hyprlock # Screen locking utility
    hyprpicker # Colorpicker utility
    hyprsunset # Bluelight filter
    libnotify # Send messages to notification daemon
    libreoffice # MSOffice btfo
    # networkmanagerapplet # Wifi dropdown menu
    networkmanager_dmenu # Manage wifi with dmenu
    nsxiv # Image viewer
    nwg-displays
    pcmanfm # Graphical file manager
    pinentry-rofi # Rofi frontend for pinentry program
    quickshell # Use QT to create widgets
    rofi # Menu prompt program
    rofi-pass # Rofi frontend for password store
    slurp # Screen selection utility
    st # Suckless Simple Terminal
    swaylock # Wayland session locker
    awww # Sets background images
    texlive.combined.scheme-full # LaTeX to create documents
    tor-browser # Onion network browser
    typst # Cool, minimal LaTeX alternative
    ungoogled-chromium # If I need a special chrome feature
    waybar # Status bar
    wayland-utils
    wdisplays # Arnadr substitute
    wl-clipboard # Copy/paste utility
    wlr-randr # Xrandr substitute
    xcursor-themes
    zathura # Minimalist PDF reader
    zen-browser # Better firefox
    intel-gpu-tools # Tools for intel GPU
    mesa-demos # Tools for Mesa drivers

    thunar # Graphical file manager
    tumbler # Thumbnailer service

    # libsForQt5.qt5.qtsvg # Allow for svg icons in QT applications
    kdePackages.qt6ct

    # GTK Themes
    lxappearance-gtk2 # Theme switcher
    gruvbox-dark-gtk

    # Custom packages
    extra-icons
  ];

  nixpkgs.overlays = [
    (final: prev: {
      typst = nixos-unstable.typst;
      zen-browser = (import flake-compat {
        src = builtins.fetchGit {
          url = "https://github.com/0xc000022070/zen-browser-flake.git";
        };
      }).outputs.packages.${pkgs.stdenv.hostPlatform.system}.default;
      st = prev.callPackage /home/vince/.config/st/default.nix {};
      extra-icons = prev.callPackage ../../derivations/extra-icons {};
      quickshell = nixos-unstable.quickshell.overrideAttrs(oa: {
        buildInputs = (oa.buildInputs or []) ++ [ nixos-unstable.qt6.qt5compat ];
      });  
    })
  ];
}

