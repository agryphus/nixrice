{ config, pkgs, ... }:

{
  i18n = {
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
  ];
}

