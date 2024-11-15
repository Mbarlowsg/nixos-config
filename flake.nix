{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        stylix.url = "github:danth/stylix";

        hyprland.url = "github:hyprwm/Hyprland";
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
                        inputs.stylix.nixosModules.stylix
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
                        inputs.stylix.nixosModules.stylix
                ];
            };
        };
    };
}
