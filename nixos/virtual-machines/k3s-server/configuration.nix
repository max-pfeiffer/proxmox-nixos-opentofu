{ modulesPath, config, lib, pkgs, ... }: {
    imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disko-config.nix
    ];
    boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
        efiSupport = true;
        efiInstallAsRemovable = true;
    };

    environment.systemPackages = [
        pkgs.curl
        pkgs.gitMinimal
    ];

    networking = {
            hostName = "k3s-server";
            useDHCP = false;
            firewall = {
                allowedTCPPorts = [
                    6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
                    2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
                    2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
                    ];
                allowedUDPPorts = [
                    8472 # k3s, flannel: required if using multi-node for inter-node networking
                ];
            };
    };

    services.cloud-init = {
                    enable = true;
                    network.enable = true;
    };

    services.openssh = {
            enable = true;
            settings.PermitRootLogin = "prohibit-password";
    };

    services.k3s = {
        enable = true;
        role = "server";
        disableAgent = true;
        tokenFile = "/etc/rancher/k3s/token";
        clusterInit = true;
    };

    services.qemuGuest.enable = true;

    users.users = {
        root = {
            hashedPasswordFile = "/etc/passwords/root";
        };
        max = {
            isNormalUser = true;
            extraGroups = [ "wheel" ];
            hashedPasswordFile = "/etc/passwords/max";
        };
    };

    system.stateVersion = "24.05";
}