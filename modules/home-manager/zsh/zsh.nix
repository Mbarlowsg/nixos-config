{ config, pkgs, inputs, home-manager, ... }:
{
    # Configure zsh
    programs.zsh = {
        enable = true;
        dotDir = ".config/zsh";

        # built in plugins
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        # oh-my-zsh 
        oh-my-zsh = {
            enable = true;
            theme = "robbyrussell";
            plugins = [
                "git"
                "npm"
                "history"
                "node"
                #"deno"
            ];
        };
        
        # Added to .zshrc
        # initExtra = ''
        #
        # '';
        #
        # localVariables = ''
        #
        # '';

        # Set location of .zshrc
        ## not needed if zsh is configured in zsh.nix
        # home.'.zshrc' = {
        #     source = ./.zshrc;
        #     recursive = true;
        # };
    };

    # oh-my-posh
    programs.oh-my-posh = {
        enable = true;
        enableZshIntegration = true;
        settings 
            = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile ./oh-my-posh-config.json));
    };
}
