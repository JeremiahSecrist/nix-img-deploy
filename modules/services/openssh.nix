{ config, pkgs, lib, ... }:

{
    services.openssh = lib.mkDefault {
        enable = true;
        settings = {
            KexAlgorithms = [ "curve25519-sha256@libssh.org" ];
            KbdInteractiveAuthentication = false;
            PasswordAuthentication = false;
            PermitRootLogin = "no";
        };
        openFirewall = true;
        startWhenNeeded = true;
    };
    security.pam = lib.mkDefault {
        enableSSHAgentAuth = true;
        services.sudo.sshAgentAuth = true;
    };
}