{
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, nur, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; }; # You can pass special arguments here
      modules = [
        { nixpkgs.overlays = [ nur.overlays.default ]; }
        { nixpkgs.config.allowUnfree = true; }
        ./hosts/nixos
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.albert = import ./home.nix;

          # Optionally, you can pass nixpkgs to your home.nix modules
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  };
}
