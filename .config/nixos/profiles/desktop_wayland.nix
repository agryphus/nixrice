{ config, pkgs, ... }:

{
  # Or else swaylock will not accept correct password
  security.pam.services.swaylock = {};

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

  fonts.packages = with pkgs; [
    source-han-sans
    source-han-serif
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  programs = {
    hyprland = {
      enable = true;
      enableNvidiaPatches = true;
      xwayland.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    blueman # Bluetooth manager
    dunst # Notification daemon
    eww-wayland
    firefox # My browser of choice
    foot # Wayland native terminal
    hyprland-autoname-workspaces
    hyprpaper
    kanshi # Autorandr substitute
    libnotify # Send messages to notification daemon
    libreoffice # MSOffice btfo
    pinentry-rofi # Rofi frontend for pinentry program
    pyprland # Plugin manager for Hyprland
    rofi # Menu prompt program
    rofi-pass # Rofi frontend for password store
    swaylock # Wayland session locker
    swww # Sets background images
    texlive.combined.scheme-full # LaTeX to create documents
    typst # Cool, minimal LaTeX alternative
    ungoogled-chromium # If I need a special chrome feature
    waybar # Status bar
    wdisplays # Arnadr substitute
    wlr-randr # Xrandr substitute

    # GTK Themes
    lxappearance-gtk2 # Theme switcher
    gruvbox-dark-gtk
  ];

  nixpkgs.overlays = [
    (self: super: {
      wlroots-hyprland-nvidia = super.wlroots-hyprland-nvidia.overrideAttrs (oa: {
        patches = (oa.patches or [ ]) ++ [
          /home/vince/misc/DisplayLink_v2.patch
        ];
      });
    })
  ];
}

