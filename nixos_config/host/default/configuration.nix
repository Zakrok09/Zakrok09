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
            jetbrains.webstorm
            jetbrains.idea-ultimate
	        jetbrains.rust-rover
            jetbrains-toolbox
            
            protonvpn-gui
            piper

            stable.maven
            stable.gradle

            # stable
	        stable.librewolf
            stable.home-manager
	        stable.python3
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
            "joan" = import ./joan-home.nix;
        };
    };

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
	nodejs
	stable.chromium
    ];

    system.stateVersion = "25.05";
}
