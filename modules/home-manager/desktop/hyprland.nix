{ config, pkgs, inputs, lib, home-manager, ... }:
let
    inherit (lib) mkOption types;
    startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
        ${pkgs.waybar}/bin/waybar 
    '';
in
{
    options.myHomeManager.monitors = lib.mkOption {
        type = types.attrsOf (types.submodule {
            options = {
                primary = mkOption {
                    type = types.bool;
                    default = false;
                };
                width = mkOption {
                    type = types.int;
                    example = 1920;
                };
                height = mkOption {
                    type = types.int;
                    example = 1080;
                };
                refreshRate = mkOption {
                    type = types.float;
                    default = 60;
                };
                x = mkOption {
                    type = types.int;
                    default = 0;
                };
                y = mkOption {
                    type = types.int;
                    default = 0;
                };
                enabled = mkOption {
                    type = types.bool;
                    default = true;
                };
                # workspace = mkOption {
                #   type = types.nullOr types.str;
                #   default = null;
                # };
            };
        });
        default = {};
    };

    options.myHomeManager.workspaces = mkOption {
        type = types.attrsOf (types.submodule {
            options = {
                monitorId = mkOption {
                    type = types.int;
                    default = false;
                };
                autostart = mkOption {
                    type = types.listOf types.str;
                    default = [];
                };
            };
        });
    default = {};
    };

    config = {
        # myHomeManager.waybar.enable = true;
        wayland.windowManager.hyprland = {
            enable = true;
    # set the flake package
            package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
            settings = {
                exec-once = ''${startupScript}/bin/start''; # executed on startup
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

                input = {
                    kb_layout = "us";
                    kb_variant = "";
                    kb_model = "";

                    follow_mouse = 1;

                    touchpad = {
                        natural_scroll = false;
                    };

                    force_no_accel = true;

                    sensitivity = 0.0; # -1.0 - 1.0, 0 means no modification.

                };

                bindm = [
                    # add binds here
                ];

            };
            plugins = [
    # put plugins here (eitehr path of package name from hyprland-plugins)
            ];
        };
        home.packages = with pkgs; [
            wl-clipboard
            rofi-wayland
            waybar
        ];
    };

}

