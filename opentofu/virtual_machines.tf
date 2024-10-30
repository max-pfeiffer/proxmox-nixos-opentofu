resource "proxmox_vm_qemu" "k3s_server" {
        depends_on = [terraform_data.nixos_cloud_init_template]
        name = "k3s-server"
        desc = "Control Node"
        target_node = var.proxmox_target_node
        agent = 1
        clone = local.nixos_cloud_init_template_name
        vm_state = "running"
        cores = 1
        memory = 4096
        boot = "order=virtio0"

        vga {
                type = "std"
        }

        disk {
                slot = "ide2"
                type = "cloudinit"
                storage = "local-lvm"
        }

        disk {
                slot = "virtio0"
                type = "disk"
                storage = "local-lvm"
                size = "10240M"
                discard = true
        }

        network {
                model = "virtio"
                bridge = "vmbr0"
        }

        # Cloud init setup
        os_type = "cloud-init"
        ipconfig0 = "ip=${local.k3s_server_ip_address}/24,gw=192.168.1.1"
        ciuser     = "root"
        sshkeys    = chomp(tls_private_key.nixos_provisioning.public_key_openssh)
}


resource "terraform_data" "k3s_server_nixos_initial_install" {
        depends_on = [
                proxmox_vm_qemu.k3s_server,
                local_file.k3s_server_user_root_public_key,
                local_file.k3s_server_user_max_public_key,
                local_file.k3s_server_root_user_password_file,
                local_file.k3s_server_max_user_password_file,
                local_file.k3s_agent_1_k3s_token,
        ]

         provisioner "local-exec" {
                environment = {
                        SSH_PRIVATE_KEY = chomp(tls_private_key.nixos_provisioning.private_key_openssh)
                }
                interpreter = ["nix-shell", "-p", "nixos-anywhere", "--command"]
                command = "nixos-anywhere --build-on-remote --extra-files ${local.k3s_server_extra_files_dir} -f ${local.k3s_server_configuration_dir}#proxmox root@${local.k3s_server_ip_address}"
        }
}


resource "proxmox_vm_qemu" "k3s_agent_1" {
        depends_on = [terraform_data.nixos_cloud_init_template, proxmox_vm_qemu.k3s_server]
        name = "k3s-agent-1"
        desc = "Worker Node 1"
        target_node = var.proxmox_target_node
        agent = 1
        clone = local.nixos_cloud_init_template_name
        vm_state = "running"
        cores = 2
        memory = 8192
        boot = "order=virtio0"

        vga {
                type = "std"
        }

        disk {
                slot = "ide2"
                type = "cloudinit"
                storage = "local-lvm"
        }

        disk {
                slot = "virtio0"
                type = "disk"
                storage = "local-lvm"
                size = "10240M"
                discard = true
        }

        network {
                model = "virtio"
                bridge = "vmbr0"
        }

        # Cloud init setup
        os_type = "cloud-init"
        ipconfig0 = "ip=${local.k3s_agent_1_ip_address}/24,gw=192.168.1.1"
        ciuser     = "root"
        sshkeys    = chomp(tls_private_key.nixos_provisioning.public_key_openssh)
}


resource "terraform_data" "k3s_agent_1_nixos_initial_install" {
        depends_on = [
                proxmox_vm_qemu.k3s_agent_1,
                local_file.k3s_agent_1_user_root_public_key,
                local_file.k3s_agent_1_user_max_public_key,
                local_file.k3s_agent_1_root_user_password_file,
                local_file.k3s_agent_1_root_user_password_file,
                local_file.k3s_agent_1_k3s_token,
        ]

         provisioner "local-exec" {
                environment = {
                        SSH_PRIVATE_KEY = chomp(tls_private_key.nixos_provisioning.private_key_openssh)
                }
                interpreter = ["nix-shell", "-p", "nixos-anywhere", "--command"]
                command = "nixos-anywhere --build-on-remote --extra-files ${local.k3s_agent_1_extra_files_dir} -f ${local.k3s_agent_1_configuration_dir}#proxmox root@${local.k3s_agent_1_ip_address}"
        }
}


resource "proxmox_vm_qemu" "k3s_agent_2" {
        depends_on = [terraform_data.nixos_cloud_init_template, proxmox_vm_qemu.k3s_server]
        name = "k3s-agent-2"
        desc = "Worker Node 2"
        target_node = var.proxmox_target_node
        agent = 1
        clone = local.nixos_cloud_init_template_name
        vm_state = "running"
        cores = 2
        memory = 8192
        boot = "order=virtio0"

        vga {
                type = "std"
        }

        disk {
                slot = "ide2"
                type = "cloudinit"
                storage = "local-lvm"
        }

        disk {
                slot = "virtio0"
                type = "disk"
                storage = "local-lvm"
                size = "10240M"
                discard = true
        }

        network {
                model = "virtio"
                bridge = "vmbr0"
        }

        # Cloud init setup
        os_type = "cloud-init"
        ipconfig0 = "ip=${local.k3s_agent_2_ip_address}/24,gw=192.168.1.1"
        ciuser     = "root"
        sshkeys    = chomp(tls_private_key.nixos_provisioning.public_key_openssh)
}


resource "terraform_data" "k3s_agent_2_nixos_initial_install" {
        depends_on = [
                proxmox_vm_qemu.k3s_agent_2,
                local_file.k3s_agent_2_user_root_public_key,
                local_file.k3s_agent_2_user_max_public_key,
                local_file.k3s_agent_2_root_user_password_file,
                local_file.k3s_agent_2_max_user_password_file,
                local_file.k3s_agent_2_k3s_token
        ]

         provisioner "local-exec" {
                environment = {
                        SSH_PRIVATE_KEY = chomp(tls_private_key.nixos_provisioning.private_key_openssh)
                }
                interpreter = ["nix-shell", "-p", "nixos-anywhere", "--command"]
                command = "nixos-anywhere --build-on-remote --extra-files ${local.k3s_agent_2_extra_files_dir} -f ${local.k3s_agent_2_configuration_dir}#proxmox root@${local.k3s_agent_2_ip_address}"
        }
}
