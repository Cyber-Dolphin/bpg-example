provider "proxmox" {
  endpoint = "https://proxmox.ip:8006/"
  api_token = "root@pam!terraform=your=api-key"
  insecure = true

  ssh {
    agent = true
    username = "root"
    private_key = file("./id_rsa")
  }
  
}