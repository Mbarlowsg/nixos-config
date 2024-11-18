# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, userSettings, systemSettings ... }:

{
    imports =
        [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        # can also put slylix here
        ];

# Bootloader.
    # Use systemd-boot if uefi, default to grub otherwise
    boot.loader.systemd-boot.enable = if (systemSettings.bootMode == "uefi") then true else false;
    boot.loader.efi.canTouchEfiVariables = if (systemSettings.bootMode == "uefi") then true else false;
    boot.loader.efi.efiSysMountPoint = systemSettings.bootMountPath; # does nothing if running bios rather than uefi
    boot.loader.grub.enable = if (systemSettings.bootMode == "uefi") then false else true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;
    boot.loader.grub.device = systemSettings.grubDevice; # does nothing if running uefi rather than bios

# Networking
    networking.hostName = systemSettings.profile; # Define your hostname.
    networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Flakes setup
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


# Set your time zone.
    time.timeZone = systemSettings.timezone; 
    i18n.defaultLocale = systemSettings.locale;
    i18n.extraLocaleSettings = {
        LC_ADDRESS = systemSetings.locale;
        LC_IDENTIFICATION = systemSettings.locale;
        LC_MEASUREMENT = systemSettings.locale;
        LC_MONETARY = systemSettings.locale;
        LC_NAME = systemSettings.locale;
        LC_NUMERIC = systemSettings.locale;
        LC_PAPER = systemSettings.locale;
        LC_TELEPHONE = systemSettings.locale;
        LC_TIME = systemSettings.locale;
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
        password = "asd"
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

# Wheel group gets trusted access to nix daemon
    nix.settings.trusted-users = [ "@wheel" ];

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
        gnome
    ];

    system.stateVersion = "24.05"; # Do not change without thorough checks

}
