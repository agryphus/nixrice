{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neomutt # Mail client

    lynx
    isync # Downloads the mail
    offlineimap # Downloads the mail
    msmtp # Sents the mail
  ];
}

