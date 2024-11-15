{ pkgs, ... }:

{
    stylix = {
        enable = true;
        #autoEnable = true;
        image = ./wallpaper.png;

        fonts = {

            sizes = {
                applications = 12;
                terminal = 15;
                desktop = 12;
                popups = 12;
            };

            monospace = {
                package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
                name = "JetBrainsMono Nerf Font Mono";
            };

            sansSerif = {
                package = pkgs.dejavu_fonts;
                name = "DejaVu Sans";
            };

            monospace = {
                package = pkgs.dejavu_fonts;
                name = "DejaVu Sans Mono";
            };

            emoji = {
                package = pkgs.noto-fonts-emoji;
                name = "Noto Color Emoji";
            };

        };

        opacity = {
            applications = 1.0;
            terminal = 1.0;
            desktop = 1.0;
            popups = 1.0;
        };
    };
}
