{ config, pkgs, ... }:{
    networking.firewall.checkReversePath = "loose"; # needed for tailscale
    services.tailscale.enable = true;
}