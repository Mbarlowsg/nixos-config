{ pkgs, ... }:

{
    stylix.enable = true;
    stylix.image = ./wallpaper.png;

    config.lib.stylix.colors = {
        base00: "282a36";
        base01: "363447";
        base02: "44475a";
        base03: "6272a4";
        base04: "9ea8c7";
        base05: "f8f8f2";
        base06: "f0f1f4";
        base07: "ffffff";
        base08: "ff5555";
        base09: "ffb86c";
        base0A: "f1fa8c";
        base0B: "50fa7b";
        base0C: "8be9fd";
        base0D: "80bfff";
        base0E: "ff79c6";
        base0F: "bd93f9";
    };
    # stylix.fonts = {
    #     monospace = {
    #         package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
    #         name = "JetBrainsMono Nerd Font Mono";
    #     };
    #     sansSerif = {
    #         package = pkgs.dejavu_fonts;
    #         name = "DejaVu Sans";
    #     };
    #     serif = {
    #         package = pkgs.dejavu_fonts;
    #         name = "DejaVu Serif";
    #     };
    # };
    #
    # stylix.fonts.sizes = {
    #     applications = 12;
    #     terminal = 15;
    #     desktop = 10;
    #     popups = 10;
    # };
    #
    # stylix.opacity = {
    #     applications = 1.0;
    #     terminal = 1.0;
    #     desktop = 1.0;
    #     popups = 1.0;
    # };
    #
    # stylix.polarity = "dark"; # "light" or "either"
}
