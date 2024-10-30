terraform {
        required_providers {
                local = {
                        source = "opentofu/local"
                        version = "2.5.1"
                }
                tls = {
                        source = "opentofu/tls"
                        version = "4.0.5"
                }
                time = {
                        source = "opentofu/time"
                        version = "0.12.0"
                }
                proxmox = {
                        source = "telmate/proxmox"
                        version = "3.0.1-rc4"
                }
        }
}

provider "proxmox" {
        pm_api_url= var.proxmox_api_url
        pm_api_token_id = var.proxmox_api_token_id
        pm_api_token_secret = var.proxmox_api_token_secret
        pm_tls_insecure = true
        # Switching off parallelism is necessary here, as VM provisioning fails otherwise
        # see: https://github.com/Telmate/terraform-provider-proxmox/issues/173
        pm_parallel = 1
}
