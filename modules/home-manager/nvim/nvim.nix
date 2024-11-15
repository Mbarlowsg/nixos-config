{ config, pkgs, inputs, home-manager, ... }:

{
    programs.neovim = 
    let
        toLua = str: "lua << EOF\n${str}\nEOF\n";
        toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in
    {
        enable = true;

        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
        defaultEditor = true;

        extraPackages = with pkgs; [
            xclip
            wl-clipboard
            unzip
            nodejs
            gcc
            git
        ];



    };
    # set config files in ~/.config/nvim
    home.file = {
        ".config/nvim" = {
            source = ../nvim;
            recursive = true;
        };
    };

    # add custom packages
    nixpkgs = {
        overlays = [
            (final: prev: {
                 vimPlugins = prev.vimPlugins // {
                    # add custom plugins here 
                 };
            })
        ];
    };
}

