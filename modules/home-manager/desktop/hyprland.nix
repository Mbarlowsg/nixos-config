{ pkgs, lib, config, ... }:

{
    wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        systemd.enable = true;
        settings = {
            "$mod" = "SUPER";

            bindm = [
                # mouse movements
                "$mod, mouse:272, movewindow"
                "$mod, mouse:273, resizewindow"
                "$mod ALT, mouse:272, resizewindow"
            ];
        };
    };
}
