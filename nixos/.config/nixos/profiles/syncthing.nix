{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    dataDir = "/home/vince/.local/share";
    openDefaultPorts = true;
    configDir = "/home/vince/.config/syncthing";
    user = "vince";
    group = "users";
    guiAddress = "localhost:8384";
  };

  environment.systemPackages = with pkgs; [
    syncthing # Syncing files between machines
  ];
}

