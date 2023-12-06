{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  # Implicitly downloads virtualbox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  environment.systemPackages = with pkgs; [
  ];
}

