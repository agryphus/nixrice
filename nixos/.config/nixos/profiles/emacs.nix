{ config, lib, pkgs, modulesPath, ... }:

let
  nixos-unstable = (import <nixos-unstable> {});
in {
  environment.systemPackages = with pkgs; [
    nixos-unstable.emacs30-pgtk # Transparency on Wayland requires Pure GTK

    # Misc
    ispell # Spellchecker
    fd # Find entries in filesystem.  Helps doom emacs run faster.

    # For vterm
    cmake
    libtool

    ## LSPs
    pyright
  ];
}

