{ config, pkgs, ... }:
# A template for a personal configuration file
{
  # Up to the user.  No unfree packages will be in main configuration.nix
  # nixpkgs.config.allowUnfree = true;

  users.users.vince {
    isNormalUser = true;
    extraGroups = [ # User is implicitly in the "users" group
      "wheel"   # Sudo priviledges
      "networkmanager" # Able to user NetworkManager
    ];
    packages = with pkgs; [

    ];
    shell = pkgs.zsh;

    # Set so when mutableUsers is set to "false", the user still has a way to login.
    # password = ""
  };
}

