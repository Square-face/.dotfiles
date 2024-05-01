{
    description = "Primary system flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let
        system = "x86_64-linux";
        username = "linus";
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

        homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
            extraSpecialArgs = {inherit inputs;};
            inherit pkgs;
            modules = [
                ./home.nix
                {
                    home = {
                        inherit username;
                        homeDirectory = "/home/${username}";
                    };
                }
            ];
        };
    };
}
