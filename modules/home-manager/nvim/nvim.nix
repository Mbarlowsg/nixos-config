{ config, pkgs, inputs, home-manager ... }:

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

        extraPackages = with pkgs; [
            xclip
                wl-clipboard
        ];



    };
    home.file = {
        ".config/nvim" = {
            source = ../nvim;
            recursive = true;
        };
    };
    {
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

