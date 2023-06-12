{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
        # sops-nix = {
        #     url = github:Mic92/sops-nix;
        #     inputs.nixpkgs.follows = "nixpkgs";
        # };
        nixos-generators = {
            url = "github:nix-community/nixos-generators";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    outputs = { self, nixos-generators, nixpkgs, ... }@inputs:
    let 
        system = "x86_64-linux";
        ng = nixos-generators.nixosGenerate;
    in {
        packages.x86_64-linux.default = self.outputs.goldenimage;
            goldenimage = ng {
            inherit system;
            modules = [
              ./golden-image.nix
            ];
            format = "proxmox";
            name = "goldenimage-${config.system.nixos.label}-v1.0.0";
        };
      };
}