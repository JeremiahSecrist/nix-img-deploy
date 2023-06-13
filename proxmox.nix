{ config, self, lib, ... }:
let
  releaseVersion = builtins.readFile ./release-version;
  libVersion = lib.version;
#   rev = "${";
  regex = ".*([0-9]+ [0-9]+\\.[0-9]+).*";
  removeSuffix = suffix: str: if lib.strings.hasSuffix suffix str then lib.strings.substring 0 (builtins.length str - builtins.length suffix) str else str;
  strippedVersion = builtins.match regex libVersion;
  proxmoxName = "${removeSuffix "pre" libVersion}";
in
{
    proxmox.qemuConf.name = "${proxmoxName}";  
}