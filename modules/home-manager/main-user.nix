{ lib, config, pkgs, ... }:

let
cfg = config.main-user;
in
{
    options.main-user = {
        enable
            = lib.mkEnableOption "enable user module";

        userName = lib.mkOption {
            default = "mainuser";
            description = ''
                username
                '';
        };
        
        description = lib.mkOption {
            default = "main user";
            description = ''
                user description
            '';
        };
    };

    config = lib.mkIf cfg.enable {
        users.users.${cfg.userName} = {
            isNormalUser = true;
            Password = "asd";
            description = "${cfg.description}";
            shell = pkgs.zsh;
            home = "/home/${cfg.userName}";
            extraGroups = [ "wheel" ];
            packages = with pkgs; [
            # packages are setup for use with Gnome, change packages based on DE requirements
                kdePackages.kate
#  thunderbird
            ];
        };
    };
}

