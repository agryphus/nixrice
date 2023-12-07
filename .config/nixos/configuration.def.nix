{ config, pkgs, ... }:

{
  imports = [
    # Do not remove
    ./core.nix

    # Specific profiles for this machine
    # ./profiles/lf.nix
    # ./profiles/nvim.nix
    # ./profiles/desktop_x.nix
  ];

  networking.hostName = "nix";
  time.timeZone = "America/New_York";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [    # User implicitly in "users" group
      "wheel"          # Sudo priviledges
    ];
    shell = pkgs.zsh;

    # Set so when mutableUsers is set to "false", the user still has a way to login.
    password = "";
  };
}

