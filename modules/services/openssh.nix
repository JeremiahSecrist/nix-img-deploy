{ config, pkgs, lib, ... }:

{
    services.openssh = lib.mkDefault {
        enable = true;
        openFirewall = true;
            passwordAuthentication = false;
            permitRootLogin = "no";
            kbdInteractiveAuthentication = false;
        startWhenNeeded = true;
        kexAlgorithms = [ "curve25519-sha256@libssh.org" ];
    };
    security.pam = lib.mkDefault {
        enableSSHAgentAuth = true;
        services.sudo.sshAgentAuth = true;
    };
}