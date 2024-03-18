{ config, pkgs, ... }:

let
  nixos-unstable = (import <nixos-unstable> {});
in {
  # Since I choose to run Hyprland nightly, the dependencies in the flake
  # track nixos-unstable.  This causes the installed, stable mesa drivers
  # to be out of sync with the expected drivers when launching Hyprland from
  # inside VirtualBox, causing a crash.  This upgrades the VMs drivers,
  # fixing the mis-match.  I am not sure why I do not have the same problem
  # on bare metal ¯\_(ツ)_/¯.
  system.replaceRuntimeDependencies = [
    ({ original    = pkgs.mesa;         
       replacement = nixos-unstable.mesa; })
    ({ original    = pkgs.mesa.drivers; 
       replacement = nixos-unstable.mesa.drivers; })
  ];
}

