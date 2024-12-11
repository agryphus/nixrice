{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bitbucket-cli # BitBucket Enterprise CLI
    bitbucket-server-cli # Interact with BitBucket Server (stash)
    evil-winrm # WinRM shell, for interacting with Windows machines
    feroxbuster # Directory enumerator, for Local File Inclusion exploits
    hashcat # Password hash-cracker.  More GPU optimized than John
    inetutils # Provides common network programs (telnet, ftp, hostname, ...)
    john # John the Ripper, password hash-cracking utility
    mariadb # Tools for MySQL
    nmap # Network mapper, scans ports of target machine
    openvpn # Virtual private network
    redis # Interact with redis caches
    responder # LLMNR, NBT-NS, and MDNS poisoner, rogue authentication server
    samba # Talk to SMB services (Microsoft's file sharing protocol)
    wordlists # Common wordlists, for dictionary attacks and the such
  ];

  nixpkgs.overlays = [
    (final: prev: {
      # The nix definition just imports Ruby, but running this with
      # Ruby >= 3.0 causes a runtime error due to lack of backwards
      # compatability for SortedSets.
      bitbucket-server-cli = prev.bitbucket-server-cli.override(o: {
        ruby = (import (builtins.fetchTarball {
          url = "https://github.com/NixOS/nixpkgs/archive/c407032be28ca2236f45c49cfb2b8b3885294f7f.tar.gz";
        }) {
          config.permittedInsecurePackages = [
            "ruby-2.7.8"
            "openssl-1.1.1w"
          ];
        }).ruby_2_7;
      });
    })
  ];
}

