{ config, self, lib, ... }:
{
    proxmox.qemuConf.name = "-${builtins.readFile ./release-version}-${lib.version}-${ self.rev }";  
}