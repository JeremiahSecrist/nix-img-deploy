{ config, pkgs, lib, self, ... }:

{
  imports =
    [
        ./modules/services/tailscale.nix
        ./modules/services/cloud-init.nix
        ./modules/services/openssh.nix
    ];
  # base packages
  environment.systemPackages = with pkgs; [
    helix
    tailscale
  ];

  networking = {
    hostName = "nixos-cloudinit"; # Define your hostname.
    # networkmanager.enable = true;
  };


  time.timeZone = "America/New_York";

  # Open ports in the firewall.
  networking.firewall = { 
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };
  ## main services
  system.stateVersion = "${lib.version}";

}