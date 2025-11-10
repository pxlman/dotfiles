{ lib, config, pkgs, ... }:
{
    config.development.enable = true;
    config = {

        home.packages = with pkgs; [
### OSINT
                sherlock # find usernames across social networks
### Hacking
# pwndbg.packages.${pkgs.system}.default
                docker # containerization platform
                amass # subdomain enumeration tool
                waybackurls # fetches URLs from the Wayback Machine
                theharvester # email and domain harvester
                postman # API testing tool
                ghidra # reverse engineering tool
                frida-tools # dynamic analysis tool
                binaryninja-free # reverse engineering platform
                burpsuitepro # web vulnerability scanner
                pwndbg # gdb plugin for exploit development
                rr # lightweight tool for recording and replaying program executions
                tmux # terminal multiplexer
                openvpn # VPN software
                cutter # RE platform
                binutils # binary utilities like objdump, objcopy, nm, etc.
                arp-scan # network scanning tool
                boost
                radare2 # reverse engineering framework
## Recon
                nmap # network scanner
                fping # ping multiple hosts
                nuclei # vulnerability scanner
# katana
## Web
# burpsuite
                zap # OWASP ZAP web vulnerability scanner
## Crypto
                xxd # hex dump tool
## DFIR
                exiftool # metadata extraction tool
# nuclei
## General
# cvemap
                wireshark # network protocol analyzer
                hash-identifier # identify types of hashes
## Fuzzing
                gobuster # directory/file brute-forcer
                ffuf # fast web fuzzer
                john # password cracker
                wordlists # common wordlists for password cracking and fuzzing
## Packets
# tshark
# tcpdump
# termshark
                ];
                programs.tmux.enable = true;
    };
}
