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
            hostName = "k3s-agent-1";
            useDHCP = false;
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
        role = "agent";
        tokenFile = "/etc/rancher/k3s/token";
        serverAddr = "https://192.168.1.150:6443";
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