{ config, pkgs, lib, ... }:
{
    users.users.arouzing = {
    isNormalUser = true;
    initialHashedPassword = "$6$tucSnzN8mqHQo/Fd$Q/RtaTpoXN0xnlLAFy6ohWWYuTYd54CXaCrocV1vgFRQVuONga1LyzwdJ0vXa.NT6MRcO7IXNQ3YeURJsSdP61";
    openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJAGm66rJsr8vjRCYDkH4lEPncPq27o6BHzpmRmkzOiM"
    ];
    description = "admin";
    extraGroups = [ "wheel" ];
  };
}