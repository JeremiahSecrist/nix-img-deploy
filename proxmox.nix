{ config, self, lib, ... }:
let
  releaseVersion = builtins.readFile ./release-version;
  libVersion = lib.version;
#   rev = "${";
  regex = ".*([0-9]+ [0-9]+\\.[0-9]+).*";
  strippedVersion = builtins.match regex libVersion;
  proxmoxName = "${releaseVersion}-${if strippedVersion != null then strippedVersion else}";
in
{
    proxmox.qemuConf.name = "${proxmoxName}-${self.rev}}";  
}