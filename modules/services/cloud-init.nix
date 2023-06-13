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
        initialPassword = "changeme!!";
    };

    services.cloud-init = {
        enable = true;
        network.enable = true;
        config = ''
          system_info:
            distro: nixos
            network:
              renderers: [ 'networkd' ]
            default_user:
              name: ops
          users:
              - default
          ssh_pwauth: false
          chpasswd:
            expire: false
          cloud_init_modules:
            - migrator
            - seed_random
            - growpart
            - resizefs
          cloud_config_modules:
            - disk_setup
            - mounts
            - set-passwords
            - ssh
          cloud_final_modules: []
          '';
      };
}