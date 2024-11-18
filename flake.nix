{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        stylix.url = "github:danth/stylix";

        hyprland.url = "github:hyprwm/Hyprland?submodules=1";
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let 
        lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in
    {
        nixosConfigurations = {
            default = lib.nixosSystem {
                specialArgs = {inherit inputs;};
                modules = [
                    ./hosts/default/configuration.nix
                        inputs.home-manager.nixosModules.default
                        inputs.stylix.nixosModules.stylix
                ];
            };
            test = lib.nixosSystem {
                specialArgs = {inherit inputs;};
                modules = [
                    ./hosts/test/configuration.nix
                        inputs.home-manager.nixosModules.default
                ];
            };

        };

        homeConfigurations = {
            michael = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = []; # put home.nix here
            };
        };
    };
}
