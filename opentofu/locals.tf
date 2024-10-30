locals {
  repo_root = "${dirname(abspath(path.root))}"
  nixos_docker_context = "${local.repo_root}/nixos"
  nixos_anywhere_config = "${local.repo_root}/nixos-anywhere/default.nix"
  private_key = "${local.repo_root}/opentofu/private.key"

  # Proxmox
  proxmox_vma_dump_directory = "/var/lib/vz/dump"
  proxmox_iso_image_directory = "/var/lib/vz/template/iso"

  # NixOS cloud init template
  nixos_cloud_init_template_name = "nixos-cloud-init"
  nixos_cloud_init_template_dir = "${local.repo_root}/nixos/cloud-init-template"
  nixos_cloud_init_template_configuration_file = "${local.nixos_cloud_init_template_dir}/configuration.nix"
  nixos_cloud_init_template_reference_file = "${local.nixos_cloud_init_template_dir}/qcow2_file_path.txt"
  nixos_cloud_init_template_vm_id = "1000"

  # NixOS VMs
  virtual_machines_dir = "${local.repo_root}/nixos/virtual-machines"

  # K3s Server
  k3s_server_ip_address = "192.168.1.150"
  k3s_server_configuration_dir = "${local.virtual_machines_dir}/k3s-server"
  k3s_server_configuration_file = "${local.k3s_server_configuration_dir}/configuration.nix"
  k3s_server_configuration_file_template = "${local.k3s_server_configuration_dir}/configuration.nix.tftpl"
  k3s_server_extra_files_dir = "${local.k3s_server_configuration_dir}/extra-files"
  k3s_server_extra_files_ssh_authorized_keys_dir = "${local.k3s_server_extra_files_dir}/etc/ssh/authorized_keys.d"
  k3s_server_extra_files_passwords_dir = "${local.k3s_server_extra_files_dir}/etc/passwords"
  k3s_server_extra_files_token_file = "${local.k3s_server_extra_files_dir}/etc/rancher/k3s/token"

  # K3s Agent 1
  k3s_agent_1_ip_address = "192.168.1.151"
  k3s_agent_1_configuration_dir = "${local.virtual_machines_dir}/k3s-agent-1"
  k3s_agent_1_configuration_file = "${local.k3s_agent_1_configuration_dir}/configuration.nix"
  k3s_agent_1_configuration_file_template = "${local.k3s_agent_1_configuration_dir}/configuration.nix.tftpl"
  k3s_agent_1_extra_files_dir = "${local.k3s_agent_1_configuration_dir}/extra-files"
  k3s_agent_1_extra_files_ssh_authorized_keys_dir = "${local.k3s_agent_1_extra_files_dir}/etc/ssh/authorized_keys.d"
  k3s_agent_1_extra_files_passwords_dir = "${local.k3s_agent_1_extra_files_dir}/etc/passwords"
  k3s_agent_1_extra_files_token_file = "${local.k3s_agent_1_extra_files_dir}/etc/rancher/k3s/token"

  # K3s Agent 2
  k3s_agent_2_ip_address = "192.168.1.152"
  k3s_agent_2_configuration_dir = "${local.virtual_machines_dir}/k3s-agent-2"
  k3s_agent_2_configuration_file = "${local.k3s_agent_2_configuration_dir}/configuration.nix"
  k3s_agent_2_configuration_file_template = "${local.k3s_agent_2_configuration_dir}/configuration.nix.tftpl"
  k3s_agent_2_extra_files_dir = "${local.k3s_agent_2_configuration_dir}/extra-files"
  k3s_agent_2_extra_files_ssh_authorized_keys_dir = "${local.k3s_agent_2_extra_files_dir}/etc/ssh/authorized_keys.d"
  k3s_agent_2_extra_files_passwords_dir = "${local.k3s_agent_2_extra_files_dir}/etc/passwords"
  k3s_agent_2_extra_files_token_file = "${local.k3s_agent_2_extra_files_dir}/etc/rancher/k3s/token"
}
