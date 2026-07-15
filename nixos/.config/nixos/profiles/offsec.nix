{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
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
}

