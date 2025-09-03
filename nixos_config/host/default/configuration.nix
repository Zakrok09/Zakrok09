{ pkgs, system, stable, inputs, ... }: {
    imports =
        [
            ./hardware-configuration.nix
            inputs.home-manager.nixosModules.default
            ../../modules/nixos/nvidia.nix
            ../../modules/nixos/gnome.nix
        ];

    # FLAKES
    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        substituters = ["https://hyprland.cachix.org"];
        trusted-substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
   
    # HYPRLAND
    programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
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
   
    # running unpatchd dynamic binaries
    programs.nix-ld.enable = true;

    # Bootloader.
    boot.loader.systemd-boot = {
        enable = true;
    };
    boot.loader.efi.canTouchEfiVariables = true;

    # Networking
    networking.hostName = "nixislovepc";
    networking.networkmanager.enable = true; #enable it

    # Timezone
    time.timeZone = "Europe/Amsterdam";
    i18n.defaultLocale = "en_US.UTF-8";

    # Enable the X11 windowing system.
    services.xserver = {
        enable = true;
        xkb = {
            layout = "us";
            variant = "";
        };
    };

    # Enable Docker
    virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
    };

    # Configure keymap in X11

    # Enable CUPS to print documents.
    services.printing.enable = true;
    services.smartd.enable = true;

    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    # Enable Piper ratbagd
    services.ratbagd.enable = true;

    # USER SETTING
    users.users.eccyboo = {
        isNormalUser = true;
        description = "eccyboo";
        extraGroups = [ "networkmanager" "wheel" "docker" ];
        packages = with pkgs; [
            #unstable
            jetbrains-toolbox

            librewolf
            home-manager
            piper

            # stable
        ];
    };

    users.users.joan = {
        isNormalUser = true;
        description = "joan baban";
        extraGroups = ["docker"];
        packages = with pkgs; [
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
	
    fonts.packages = with pkgs; [
        jetbrains-mono
    ];

 
    # STEAM
	programs.steam = {
        enable = true;
        remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
	};

    # Install firefox.
    programs.firefox.enable = true;

    # SYSTEM PACKAGES
    environment.systemPackages = with pkgs; [
        wget
        git
        direnv
        neofetch
        openssl
        gnupg
        gcc
        kitty
	
        stable.chromium
    ];

    system.stateVersion = "25.05";
}
