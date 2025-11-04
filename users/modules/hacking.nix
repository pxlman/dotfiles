{ lib, config, pkgs, ... }:
{
config.development.enable = true;
config = {

    home.packages = with pkgs; [
### OSINT
        sherlock
### Hacking
# pwndbg.packages.${pkgs.system}.default
  docker
  postman
  ghidra
  binaryninja-free
            burpsuitepro
            pwndbg
            tmux
            openvpn
            cutter # RE platform
            binutils
            arp-scan
            boost
            radare2
## Recon
            nmap
            fping
# katana
## Web
# burpsuite
            zap
## Crypto
            xxd
## DFIR
            exiftool
# nuclei
## General
# cvemap
            wireshark
            hash-identifier
## Fuzzing
            gobuster
            ffuf
            john
            wordlists
## Packets
# tshark
# tcpdump
# termshark
            ];
};
}
