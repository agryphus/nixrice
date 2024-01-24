{ config, lib, pkgs, modulesPath, ... }:

{
  environment.systemPackages = with pkgs; [
    emacs29-pgtk # Transparency on Wayland requires Pure GTK

    # Misc
    ispell # Spellchecker
    fd # Find entries in filesystem.  Helps doom emacs run faster.

    # For vterm
    cmake
    libtool

    ## LSPs
    nodePackages.pyright
  ];
}

