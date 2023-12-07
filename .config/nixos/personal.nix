{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "main";
  programs.java = { enable = true; package = pkgs.javaPackages.openjfx17; };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vince = {
    isNormalUser = true;
    extraGroups = [    # User implicitly in "users" group
      "bluetooth"      
      "docker"         # Use docker
      "networkmanager" # Able to user NetworkManager
      "video"          # Permission to change backlight value
      "vboxusers"      # Make virtualbox vms
      "wheel"          # Sudo priviledges
    ];
    packages = with pkgs; [
      ardour # DAW
      docker
      gimp # Image editor
      kdenlive # Video editor
      mupen64plus # N64 Emulator
      musescore # Music notation software
      obs-studio # Screen recorder

      # Java stuff
      javaPackages.openjfx19
      jdk17

      # Unfree programs
      discord
      slack
      spotify
      zoom-us
    ];
    shell = pkgs.zsh;

    # Set so when mutableUsers is set to "false", the user still has a way to login.
    password = "";
  };
}

