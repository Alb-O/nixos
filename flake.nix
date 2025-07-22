{
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }@inputs: {
    nixosConfigurations.hp-laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.overlays = [ nur.overlays.default ]; }
        { nixpkgs.config.allowUnfree = true; }
        ./hosts/hp-laptop
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.albert = import ./home.nix;
            extraSpecialArgs = { inherit inputs; };
          };
        }
      ];
    nixosConfigurations.desktop-gtx1080 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.overlays = [ nur.overlays.default ]; }
        { nixpkgs.config.allowUnfree = true; }
        ./hosts/desktop-gtx1080
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.albert = import ./home.nix;
            extraSpecialArgs = { inherit inputs; };
          };
        }
      ];
    };
  };
};}