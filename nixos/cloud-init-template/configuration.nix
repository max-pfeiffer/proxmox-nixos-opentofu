{
  ...
}: {
    networking = {
            hostName = "nixos-cloud-init";
            useDHCP = false;
    };

    services = {
            openssh.enable = true;
            openssh.settings.PermitRootLogin = "yes";

            cloud-init = {
                    enable = true;
                    network.enable = true;
            };

            qemuGuest.enable = true;
    };

    system.stateVersion = "24.05";
}
