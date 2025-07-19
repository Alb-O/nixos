{
  description = "A basic NixOS flake with Home-Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; }; # You can pass special arguments here
      modules = [
        { nixpkgs.overlays = [ nur.overlays.default ]; }
        { nixpkgs.config.allowUnfree = true; }
        ./hosts/nixos
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
