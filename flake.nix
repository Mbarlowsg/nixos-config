{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";


    };

    outputs = { self, nixpkgs, ... }@inputs: 
        let 
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
        in
        {
            nixosConfigurations = {
                default = nixpkgs.lib.nixosSystem {
                    specialArgs = {inherit inputs;};
                    modules = [
                        ./hosts/default/configuration.nix
                        inputs.home-manager.nixosModules.default
                    ];
                };
                plasma = nixpkgs.lib.nixosSystem {
                    specialArgs = {inherit inputs;};
                    modules = [
                        ./hosts/plasma/configuration.nix
                        inputs.home-manager.nixosModules.default
                    ];
                };
                hyprland = nixpkgs.lib.nixosSystem {
                    specialArgs = {inherit inputs;};
                    modules = [
                        ./hosts/hyprland/configuration.nix
                        inputs.home-manager.nixosModules.default
                    ];
                };
            };
        };
}
