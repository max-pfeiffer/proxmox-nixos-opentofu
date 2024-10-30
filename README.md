# proxmox-nixos-opentofu
A proof of concept project to provision NixOS VMs on Proxmox hypervisor with OpenTofu.

## Requirements
You need to have installed on your local machine:
* [Nix](https://nixos.org/)
* [OpenTofu](https://opentofu.org/)

### MacOS and/or ARM processors
When provisioning using a macOS machine or a machine with ARM processor, you need to set up a Linux builder for building
NixOS images with x86_64-linux architecture.
[Nixpgs contains a Linux builder](https://nixos.org/manual/nixpkgs/stable/#sec-darwin-builder) which you can quickly set up.

[Nix-darwin](https://github.com/LnL7/nix-darwin) contains a [linux-builder module](https://github.com/LnL7/nix-darwin/blob/master/modules/nix/linux-builder.nix)
which is setting up the Linux builder automatically. But sadly this is currently broken.

#### Configure nix-darwin manually
For details for distributed builds see the [NixOS wiki page](https://nixos.wiki/wiki/Distributed_build).
Add the following to your `.nixpkgs/darwin-configuration.nix`:
```
  # Linux builder
  nix.settings.trusted-users = [ "root" "<YOUR PERSONAL USER>"];
  nix.distributedBuilds = true;
  nix.buildMachines = [ {
    hostName = "linux-builder";
    protocol = "ssh-ng";
    sshUser = "builder";
    sshKey = "/etc/nix/builder_ed25519";
    publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUpCV2N4Yi9CbGFxdDFhdU90RStGOFFVV3JVb3RpQzVxQkorVXVFV2RWQ2Igcm9vdEBuaXhvcwo=";
    systems = [ "x86_64-linux" ];
    maxJobs = 4;
    supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
  } ];
```

#### Run the Linux builder
Run the Linux builder according to [it's documentation](https://nixos.org/manual/nixpkgs/stable/#sec-darwin-builder):
```shell
nix run nixpkgs#darwin.linux-builder
```

## Provisioning
To try it out first put your configuration in `opentofu/credentials.auto.tfvars`. See example file.

Then run:
```shell
tofu init
tofu plan
tofu apply
```

## Information Sources
* Terraform providers/modules
  * [terraform-provider-proxmox](https://github.com/Telmate/terraform-provider-proxmox)
* Nix
  * [nixos-generators](https://github.com/nix-community/nixos-generators)
  * [nixos-anywhere](https://github.com/nix-community/nixos-anywhere)
* NixOS
  * [Proxmox Virtual Environment](https://nixos.wiki/wiki/Proxmox_Virtual_Environment)
