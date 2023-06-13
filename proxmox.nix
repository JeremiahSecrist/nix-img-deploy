{ config, self, lib, ... }:
let
  releaseVersion = builtins.readFile ./release-version;
  libVersion = lib.version;
#   rev = "${";
  regex = ".*([0-9]+ [0-9]+\\.[0-9]+).*";
  strippedVersion = builtins.match regex libVersion;
  proxmoxName = "${releaseVersion}-${strippedVersion}-${libVersion}";
in
{
    proxmox.qemuConf.name = "${proxmoxName}";  
}