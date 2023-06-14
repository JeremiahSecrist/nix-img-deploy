{ config, pkgs, lib, ... }: {
    # Needed  so cloud init networks work.
    systemd.network.enable = true;

    # ops should not need password because cloud init automation.
    security.sudo.extraRules = [
        { users = [ "ops" ]; commands = [ { command = "ALL"; options = [ "NOPASSWD" "SETENV" ];} ];  }
    ];

    # ops user needed for cloud init
    users.users.ops = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
    };

    services.cloud-init = {
        enable = true;
        network.enable = true;
        settings = {
          system_info = {
            distro = "nixos";
            network = {
              renderers = [ "networkd" ];
            };
            default_user = {
              name = "ops";
            };
          };
          users = [ "default" ];
          chpasswd = {
            expire= false;
          };
          ssh_pwauth = false;
          disable_root = true;
          preserve_hostname = false;
        };
      };
}