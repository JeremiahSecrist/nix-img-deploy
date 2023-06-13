{ config, self, ... }:
{
    proxmox.qemuConf.name = "${ self.rev }";  
}