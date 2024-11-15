{ config, pkgs, inputs, ... }:

{
    wayland.windowManager.hyprland = {
        enable = true;
# set the flake package
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        settings = {
            # put hyprland settings here 
        };
        plugins = [
            # put plugins here (eitehr path of package name from hyprland-plugins)
        ];
    };
}

