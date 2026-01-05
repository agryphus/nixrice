{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim

    # LSPs
    clang
    clang-tools
    lua-language-server
    python3Packages.python-lsp-server

    # Misc
    ripgrep # Used by telescope
    gcc
    unzip
  ];
}

