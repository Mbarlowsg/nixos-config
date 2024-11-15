{ pkgs, ... }:

{
    stylix.enable = true;
    stylix.image = ./wallpaper.png;

    stylix.fonts = {
        monospace = {
            package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
            name = "JetBrainsMono Nerd Font Mono";
        };
        sansSerif = {
            package = pkgs.dejavu_fonts;
            name = "DejaVu Sans";
        };
        serif = {
            package = pkgs.dejavu_fonts;
            name = "DejaVu Serif";
        };
    };

    stylix.fonts.sizes = {
        applications = 12;
        terminal = 15;
        desktop = 10;
        popups = 10;
    };

    stylix.opacity = {
        applications = 1.0;
        terminal = 1.0;
        desktop = 1.0;
        popups = 1.0;
    };

    stylix.polarity = "dark"; # "light" or "either"
}
