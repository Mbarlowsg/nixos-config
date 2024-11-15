{ config, pkgs, inputs, home-manager ... }:
{
    # Configure zsh
    programs.zsh = {
        enable = true;
        dotDir = ".config/zsh";

        # built in plugins
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;

        # oh-my-zsh 
        os-my-zsh = {
            enable = true;
            theme = "robbyrussell";
            oh-my-zsh.plugins = [
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
            = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile "./oh-my-posh-config.json"));
    };
}
