{ config, pkgs, lib, ... }: {
    services.cloud-init = {
        enable = true;
        network.enable = true;
    };
}