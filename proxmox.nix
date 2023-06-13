{ config, self, ... }:
{
    proxmox.qemuConf.name = "${builtins.readFile ./release-version}-${ self.rev }";  
}