{ config, pkgs, ... }:

{
  programs.java = {
    enable = true;
    package = pkgs.javaPackages.openjfx17;
  };

  environment.systemPackages = with pkgs; [
    javaPackages.openjfx17
    jdk17
  ];
}

