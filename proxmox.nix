{ config, self, lib, ... }:
{
    proxmox.qemuConf.name = "${builtins.readFile ./release-version}-${ lib.strings.removeSuffix "pre-git" lib.version}-${ self.rev }";  
}