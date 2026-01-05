{ config, pkgs, lib, ... }:

{
  i18n.inputMethod = {
    # Have to install fcitx5 through here so that the binary is patched to be
    # able to see the addons. If also installed through system packages, the
    # binary without addonds will take precedence.
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        qt6Packages.fcitx5-with-addons
        qt6Packages.fcitx5-configtool
        qt6Packages.fcitx5-chinese-addons
        fcitx5-rime
        fcitx5-m17n
      ];
    };
  };

  fonts.packages = with pkgs; [
    source-han-sans
    source-han-serif
  ];
}

