{ config, pkgs, inputs, ... }:

{
    nixpkgs = {
        overlays = [
            (final: prev: {
             vimPlugins = prev.vimPlugins // {
# add custom plugins here 
             };
             };
             })
        ];
};

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

    plugins = with pkgs.vimPlugins; [

    ];

    extraLuaConfig = ''
        ${builtins.readFile ./plugins/options.lua}
        ${builtins.readFile ./plugins/options.lua}
    '';

# extraLuaConfig = ''
#   ${builtins.readFile ./nvim/options.lua}
#   ${builtins.readFile ./nvim/plugin/lsp.lua}
#   ${builtins.readFile ./nvim/plugin/cmp.lua}
#   ${builtins.readFile ./nvim/plugin/telescope.lua}
#   ${builtins.readFile ./nvim/plugin/treesitter.lua}
#   ${builtins.readFile ./nvim/plugin/other.lua}
# '';
};

}
