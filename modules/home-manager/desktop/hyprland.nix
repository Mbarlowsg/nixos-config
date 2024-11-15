{ config, pkgs, inputs, ... }:

{
    wayland.windowManager.hyprland = {
        enable = true;
# set the flake package
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        settings = {
# put hyprland settings here 
            monitor =
                lib.mapAttrsToList
                (
                    name: m: let
                    resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
                    position = "${toString m.x}x${toString m.y}";
                    in "${name},${
                    if m.enabled
                    then "${resolution},${position},1"
                    else "disable"
                         }"
                )
                (config.myHomeManager.monitors);
        };
        plugins = [
# put plugins here (eitehr path of package name from hyprland-plugins)
        ];
    };
}

