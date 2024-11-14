{ config, pkgs, inputs, ... }:

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


extraLuaConfig = ''
  ${builtins.readFile ./init.lua}
  ${builtins.readFile ./lua/core/options.lua}
  ${builtins.readFile ./lua/core/keymaps.lua}
  ${builtins.readfile ./lua/plugins/colorscheme.lua}
  ${builtins.readfile ./lua/plugins/harpoon.lua}
  ${builtins.readfile ./lua/plugins/indent-blankline-nvim.lua}
  ${builtins.readfile ./lua/plugins/lualine-nvim.lua}
  ${builtins.readfile ./lua/plugins/noice-nvim.lua}
  ${builtins.readfile ./lua/plugins/nvim-autopairs.lua}
  ${builtins.readfile ./lua/plugins/nvim-cmp.lua}
  ${builtins.readfile ./lua/plugins/nvim-dap-ui.lua}
  ${builtins.readfile ./lua/plugins/nvim-dap-virtual-text.lua}
  ${builtins.readfile ./lua/plugins/nvim-lspconfig.lua}
  ${builtins.readfile ./lua/plugins/nvim-tree.lua}
  ${builtins.readfile ./lua/plugins/nvim-treesitter.lua}
  ${builtins.readfile ./lua/plugins/quickfixdd.lua}
  ${builtins.readfile ./lua/plugins/vim-commentary.lua}
  ${builtins.readfile ./lua/plugins/vim-maximizer.lua}
'';
};

}

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
