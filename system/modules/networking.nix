{config, lib, pkgs, ...}:

{
# Firewall settings
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 
            22000 # syncthing
            8384 # syncthing gui
            7777 # miniserve
            7778 
            9999 
            8888 
            8080 
            8081 
            8000 
            80 
            443 
            12345 
            21 # vsftp
            53317 
            69 # tftp
            2049 # nfs
            111 # rpcbind for the nfs server
            20048 # nfs server
        ];
        allowedUDPPorts = [ 
            22000 # syncthing
            21027
            69 # tftp
            2049 # nfs
            111 # rpcbind for the nfs server
            20048 # nfs server
        ];
    };
# Networking Hostname
    networking.hostName = "Ahmed"; # Define your hostname.
# Wifi enabling
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    # For the qemu
    networking.firewall.trustedInterfaces = [ "tap0" ];
# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
