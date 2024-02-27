{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim

    # LSPs
    clang-tools
    lua-language-server

    # Misc
    ripgrep # Used by telescope
    gcc
    unzip
  ];
}

