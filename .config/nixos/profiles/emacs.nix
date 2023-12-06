{ config, lib, pkgs, modulesPath, ... }:

{
  services.emacs.enable = true;

  environment.systemPackages = with pkgs; [
    emacs29-gtk3

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

