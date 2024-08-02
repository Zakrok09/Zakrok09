{ config, pkgs, stable, lib, inputs, ... }:

{
    # Home Manager needs a bit of information about you and the paths it should
    home = {
        username = "eccyboo";
        homeDirectory = "/home/eccyboo";
        stateVersion = "24.05";
    };

    imports = [
        ../../modules/home-manager/hyprland.nix
    ];

    home.packages = with stable; [
        #unstable
        networkmanagerapplet
        waybar
        signal-desktop
        tcpdump
        chromium
        spotify
        xclip
    ];

    home.sessionVariables = {
        # EDITOR = "emacs";
    };
  
    programs = {
        direnv = {
            enable = true;
            enableBashIntegration = true; # see note on other shells below
            nix-direnv.enable = true;
        };

        bash = {
            enable = true;
            shellAliases = {
                ll = "ls -l";
                rebuild = "sudo nixos-rebuild switch --flake ./#myNixos";
                dotenv = "export $(cat .env | xargs)";
                dockerb = "docker-compose up -d --build";
            };
        };

        librewolf = {
            enable = true;
            # Enable WebGL
            settings = {
                "webgl.disabled" = false;
                "identity.fxaccounts.enabled" = true;
            };
        };
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}

