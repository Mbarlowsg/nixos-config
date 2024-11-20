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
# ---- SYSTEM SETTINGS ---- #
        systemSettings = {
            system = "x86_64-linux"; # system arch
            hostname = "nixOS"; # hostname
            profile = "default"; # select a profile defined from my profiles directory
            timezone = "America/Chicago"; # select timezone
            locale = "en_US.UTF-8"; # select locale
            bootMode = "uefi"; # uefi or bios
            bootMountPath = "/boot"; # mount path for efi boot partition; only used for uefi boot mode
            grubDevice = ""; # device identifier for grub; only used for legacy (bios) boot mode
            gpuType = "nvidia"; # amd, intel or nvidia; only makes some slight mods for amd at the moment
        };

# ----- USER SETTINGS ----- #
        userSettings = rec {
            username = "michael"; # username
            name = "Michael"; # name/identifier
            email = "mbarlowsg@yahoo.com"; # email (used for certain configurations)
            dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
            theme = "io"; # selcted theme from my themes directory (./themes/)
            wm = "hyprland"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
            # window manager type (hyprland or x11) translator
            wmType = if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";
            browser = "firefox"; # Default browser; must select one from ./user/app/browser/
            term = "zsh"; # Default terminal command;
            font = "Intel One Mono"; # Selected font
            fontPkg = pkgs.intel-one-mono; # Font package
            editor = "nvim"; # Default editor;
            };

        lib = nixpkgs.lib;
        pkgs = nixpkgs.legacyPackages.${systemSettings.system};
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
            auto = lib.nixosSystem {
                system = systemSettings.system;
                specialArgs = {
                    inherit inputs;
                    inherit pkgs;
                    inherit userSettings;
                    inherit systemSettings;
                };
                modules = [
                    (./. + "/hosts" + ("/" + systemSettings.profile) + "/configuration.nix")
                ];
            };

        };

        homeConfigurations = {
            user = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [
                    (./. + "/hosts" + ("/" + systemSettings.profile) + "/home.nix")
                ];
                extraSpecialArgs = {
                    # pass config variables from above
                    inherit systemSettings;
                    inherit userSettings;
                    inherit inputs;
                };
            };
        };
    };
}
