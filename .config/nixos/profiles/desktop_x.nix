{ config, pkgs, ... }:

{
  environment.sessionVariables = {
    TERMINAL = "st";
  };

  security.sudo.extraConfig = ''
    %wheel ALL=(ALL:ALL) NOPASSWD: ${pkgs.systemd}/bin/systemctl restart autorandr
  '';

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

  # Monitor switching service.  Allow users to restart the service without password
  services.autorandr.enable = true;

  environment.systemPackages = with pkgs; [
    arandr # Visually move relative positions of monitors
    autorandr # Save and load xrandr profiles
    blueman # Bluetooth manager
    dunst # Notification daemon
    dwmblocks # Suckless statusbar for DWM
    dwm # Suckless tiling window manager
    feh # Image viewer I use for background setting
    firefox # My browser of choice
    libnotify # Send messages to notification daemon
    libreoffice # MSOffice btfo
    maim # Screenshot utility
    picom # X Compositor
    pinentry-rofi # Rofi frontend for pinentry program
    rofi # Menu prompt program
    rofi-pass # Rofi frontend for password store
    st # Suckless terminal
    sxhkd # Hotkey daemon
    texlive.combined.scheme-full # LaTeX to create documents
    typst # Cool, minimal LaTeX alternative
    ungoogled-chromium # If I need a special chrome feature
    xsecurelock # Session locker

    # GTK Themes
    lxappearance-gtk2 # Theme switcher
    gruvbox-dark-gtk

    # X tools
    xorg.xauth
    xclip
  ];
}

