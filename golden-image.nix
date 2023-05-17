{ config, pkgs, lib, ... }:

{
  imports =
    [
        #./modules/services/docker.nix
        ./modules/users/arouzing.nix
        ./modules/services/openssh.nix
    ];

    # base packages
    environment.systemPackages = with pkgs; [
      htop
      vim
      tailscale
    ];

  networking = {
    firewall.checkReversePath = "loose";
    hostName = "goldenimage"; # Define your hostname.
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