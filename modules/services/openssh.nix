{ config, pkgs, lib, ... }:

{
    services.openssh = lib.mkDefault {
        enable = true;
        settings = {
            kexAlgorithms = [ "curve25519-sha256@libssh.org" ];
            kbdInteractiveAuthentication = false;
            passwordAuthentication = false;
            permitRootLogin = "no";
        }
        openFirewall = true;
        startWhenNeeded = true;
    };
    security.pam = lib.mkDefault {
        enableSSHAgentAuth = true;
        services.sudo.sshAgentAuth = true;
    };
}