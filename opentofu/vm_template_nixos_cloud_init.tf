resource "terraform_data" "nixos_cloud_init_template" {
  input = {
    ssh_host = var.proxmox_host
    ssh_user = var.proxmox_ssh_user
    ssh_password = var.proxmox_ssh_password
    nixos_cloud_init_template_reference_file = local.nixos_cloud_init_template_reference_file
    proxmox_vma_dump_directory = local.proxmox_vma_dump_directory
    nixos_cloud_init_template_vm_id = local.nixos_cloud_init_template_vm_id
  }

  connection {
    type     = "ssh"
    host     = self.input.ssh_host
    user     = self.input.ssh_user
    password = self.input.ssh_password
  }

  provisioner "local-exec" {
    interpreter = ["nix-shell", "-p", "nixos-generators", "--command"]
    command = "nixos-generate -f qcow --system x86_64-linux -c ${local.nixos_cloud_init_template_configuration_file} | tail -n1 > ${self.input.nixos_cloud_init_template_reference_file}"
  }

  provisioner "file" {
    source = chomp(file(self.input.nixos_cloud_init_template_reference_file))
    destination = "${self.input.proxmox_vma_dump_directory}/${basename(chomp(file(self.input.nixos_cloud_init_template_reference_file)))}"
  }

  provisioner "remote-exec" {
    inline = [
      "qm create ${self.input.nixos_cloud_init_template_vm_id} --name ${local.nixos_cloud_init_template_name}",
      "sleep 5s",
      "qm set ${self.input.nixos_cloud_init_template_vm_id} --virtio0 local-lvm:0,import-from=${self.input.proxmox_vma_dump_directory}/${basename(chomp(file(self.input.nixos_cloud_init_template_reference_file)))}",
      "sleep 10s",
      "qm template ${self.input.nixos_cloud_init_template_vm_id}",
      "sleep 20s",
    ]
  }

  provisioner "remote-exec" {
    when = destroy
    inline = [
      "qm stop ${self.input.nixos_cloud_init_template_vm_id} && qm destroy ${self.input.nixos_cloud_init_template_vm_id} || echo \"VM ${self.input.nixos_cloud_init_template_vm_id} does not exist\"",
      "rm ${self.input.proxmox_vma_dump_directory}/${basename(chomp(file(self.input.nixos_cloud_init_template_reference_file)))}"
    ]
  }
}
