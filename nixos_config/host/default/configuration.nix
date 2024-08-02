# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, system, stable, inputs, ... }: {
    imports =
        [
            ./hardware-configuration.nix
            inputs.home-manager.nixosModules.default
            ../../modules/nixos/nvidia.nix
        ];

    # FLAKES
    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    environment.sessionVariables = {
        WLR_NO_HARDWARE_CURSORS = "1";
        NIXOS_OZONE_WL = "1";
    };
  
    hardware = {
        graphics.enable = true;
        nvidia.modesetting.enable = true;
    };

    # nixpkgs config
    nixpkgs.config = {
        allowUnsupportedSystem = true;
    };


    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Networking
    networking.hostName = "nixislovepc";
    networking.networkmanager.enable = true; #enable it

    # Timezone
    time.timeZone = "Europe/Amsterdam";
    i18n.defaultLocale = "en_US.UTF-8";

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable Docker
    virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
    };

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

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

    # USER SETTING
    users.users.eccyboo = {
        isNormalUser = true;
        description = "eccyboo";
        extraGroups = [ "networkmanager" "wheel" "docker" ];
        packages = with pkgs; [
            #unstable
            jetbrains.webstorm
            obsidian
            jetbrains-toolbox
            openssl
            telegram-desktop
            protonvpn-gui
            rustc
            rustup
            cargo
            docker-compose
            doctl
            postgresql

            # stable
            stable.librewolf
            stable.jdk20
            stable.home-manager
        ];
    };

    # home manager
    home-manager = {
        extraSpecialArgs = { inherit system inputs stable pkgs; };
        users = {
            "eccyboo" = import ./home.nix;
        };
    };

    # Install firefox.
    programs.firefox.enable = true;

    # SYSTEM PACKAGES
    environment.systemPackages = with pkgs; [
        wget
        git
        direnv
        neofetch
    ];

    system.stateVersion = "24.05";
}
