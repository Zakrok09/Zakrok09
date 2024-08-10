{ config, pkgs, stable, lib, inputs, ... }:

{
    # Home Manager needs a bit of information about you and the paths it should
    home = {
        username = "eccyboo";
        homeDirectory = "/home/eccyboo";
        stateVersion = "24.05";
    };

    imports = [
        #../../modules/home-manager/hyprland.nix
    ];

    home.packages = with stable; [
        # unstable
        pkgs.alacritty

        # non-work apps
        spotify
        signal-desktop
        discord

        # console utils
        tcpdump
        xclip

	# browsers
	chromium

        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

    fonts.fontconfig = {
        enable = true;
        defaultFonts = {
            monospace = [ "JetBrainsMono" ];
        };
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
                rebuild = "sudo nixos-rebuild switch --flake ~/zakrok_repo/nixos_config/flake.nix#default";
                dockerb = "docker-compose up -d --build";
                cds = "cd ~/zakrok_repo/nixos_config";
                clear_garbage = "";
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

