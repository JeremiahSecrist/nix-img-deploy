{ config, pkgs, lib, ... }:

{
  imports =
    [
        #./modules/services/docker.nix
        ./modules/services/cloud-init.nix
        ./modules/users/arouzing.nix
        ./modules/services/openssh.nix
    ];

  # base packages
  environment.systemPackages = with pkgs; [
    htop
    vim
    tailscale
  ];

  fileSystems."/" = {
    # label = "nixos";
    # fsType = "ext4";
    autoResize = true;
  };

  networking = {
    firewall.checkReversePath = "loose"; # needed for tailscale
    hostName = "nixos-cloudinit"; # Define your hostname.
    # networkmanager.enable = true;
  };

  services.tailscale.enable = true;

  time.timeZone = "America/New_York";

  # Open ports in the firewall.
  networking.firewall = { 
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };
  ## main services
  system.stateVersion = "22.11";

}