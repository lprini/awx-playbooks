terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.pve_endpoint
  pm_api_token_secret = var.pve_api_token
  pm_tls_insecure     = true
}
