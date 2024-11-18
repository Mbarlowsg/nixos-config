{ config, pkgs, inputs, ... }:

{
    home.username = "michael";
    home.homeDirectory = "/home/michael";

    programs.home-manager.enable = true;

    imports = [
        ../../modules/home-manager/nvim/nvim.nix
        ../../modules/home-manager/zsh/zsh.nix
        ../../modules/home-manager/desktop/gnome.nix
        # window manager should be imported here based on the userSettings
    ];

    home.stateVersion = "24.05"; # Do not change without checking the new version release notes.

    home.packages = (with pkgs; [
        hello
        zsh
        firefox
        ]);

      
    home.sessionVariables = {
        EDITOR = userSettings.editor;
        VISUAL = userSettings.editor;
        TERM = userSettings.term;
        BROWSER = userSettings.browser;
    };

    xdg.enable = true;


} 
