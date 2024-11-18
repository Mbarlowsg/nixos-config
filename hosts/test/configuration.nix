# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, userSettings, systemSettings ... }:

{
    imports =
        [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
            inputs.home-manager.nixosModules.default
        ];

# Bootloader.
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    networking.hostName = # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Flakes setup
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
    networking.networkmanager.enable = true;

# Set your time zone.
    time.timeZone = "America/New_York";

# Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

# Enable the GNOME Desktop Environment.
    services.xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
    };


# Configure keymap in X11
    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };

# Enable CUPS to print documents.
    services.printing.enable = true;

# Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

# User settings
    users.users.${userSettings.username} = {
        isNormalUser = true;
        description = userSettings.name;
        extraGroups = [ "networkmanager" "wheel" "input" "dialout" "video" "render" ];
        packages = [];
        uid = 1000;
    };


# Install firefox
    programs.firefox.enable = true;


# Install Zsh
    users.defaultUserShell = pkgs.zsh;
    environment.shells = with pkgs; [ zsh ];
    programs.zsh.enable = true;
    environment.pathsToLink = [ "/share/zsh" ];

# Set nvim as default editor
    environment.variables = { 
        EDITOR = "nvim"; 
        VISUAL = "nvim";
    };


# Allow unfree packages
    nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
    environment.systemPackages = with pkgs; [
#  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        wget
        zsh
        nodejs
        gcc
        neovim
        git
        gh
        home-manager
    ];

    system.stateVersion = "24.05"; # Do not change without thorough checks

}
