{ pkgs, lib, config, ... }:

{
    services.xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        services.xserver.desktopManager.gnome.enable = true;
        # environment.gnome.excludePackages = (with pkgs; [
        #     gnome-photos
        #     gnome-tour
        #     ]) ++ (with pkgs.gnome; [
        #     cheese # webcam tool
        #     gnome-music
        #     gedit # text editor
        #     epiphany # web browser
        #     geary # email reader
        #     gnome-characters
        #     tali # poker game
        #     iagno # go game
        #     hitori # sudoku game
        #     atomix # puzzle game
        #     yelp # Help view
        #     gnome-contacts
        #     gnome-initial-setup
        #     ]);
        # programs.dconf.enable = true;
        # environment.systemPackages = with pkgs; [
        #     gnome.gnome-tweaks
        # ];
    };


    # gtk = {
    #     enable = true;
    #
    #     iconTheme = {
    #         name = "Papirus-Dark";
    #         package = pkgs.papirus-icon-theme;
    #     };
    #
    #     theme = {
    #         name = "palenight";
    #         package = pkgs.palenight-theme;
    #     };
    #
    #     cursorTheme = {
    #         name = "Numix-Cursor";
    #         package = pkgs.numix-cursor-theme;
    #         };
    #
    #     gtk3.extraConfig = {
    #         Settings = ''
    #             gtk-application-prefer-dark-theme=1
    #         '';
    #     };
    #
    #     gtk4.extraConfig = {
    #         Settings = ''
    #             gtk-application-prefer-dark-theme=1
    #         '';
    #     };
    # };
    #
    # home.sessionVariables.GTK_THEME = "palenight";
    #
    # dconf.settings = {
    #     "org/gnome/desktop/interface" = {
    #         color-scheme = "prefer-dark";
    #     };
    #
    #     "org/gnome/shell" = {
    #         disable-user-extensions = false;
    #
    #         enabled-extensions = [
    #             # add extensions here
    #         ];
    #     };
    #
    #     "org/gnome/shell/extentions/user-theme" = {
    #         name = "palenight";
    #     };
    # };
    #

}
