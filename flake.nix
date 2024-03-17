{
    description = "Primary system flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        nix-citizen.url = "github:LovingMelody/nix-citizen";

        # Optional - updates underlying without waiting for nix-citizen to update
        nix-gaming.url = "github:fufexan/nix-gaming";
        nix-citizen.inputs.nix-gaming.follows = "nix-gaming";
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let
        system = "x86_64-linux";
        lib = nixpkgs.lib;
        pkgs = nixpkgs.legacyPackages.${system};
    in {

        nixosConfigurations.cry-nix = nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs;};
            inherit system;
            modules = [
                ./configuration.nix
            ];
        };

        homeConfigurations.linus = home-manager.lib.homeManagerConfiguration {
            extraSpecialArgs = {inherit inputs;};
            inherit pkgs;
            modules = [
                ./home.nix
            ];
        };
    };
}
