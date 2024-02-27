{ config, pkgs, ... }:

{
  programs.java = {
    enable = true;
    package = pkgs.javaPackages.openjfx17;
  };

  environment.systemPackages = with pkgs; [
    javaPackages.openjfx19
    jdk17
  ];
}

