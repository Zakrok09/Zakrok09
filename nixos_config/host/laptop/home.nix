{ config, pkgs, stable, lib, inputs, ... }:

{
    # Home Manager needs a bit of information about you and the paths it should
    home = {
        username = "eccyboo";
        homeDirectory = "/home/eccyboo";
        stateVersion = "24.11";
    };

    imports = [
        ../../modules/home-manager/gnome-manage.nix
        ../../modules/home-manager/alacritty.nix
        ../../modules/home-manager/hyprland.nix
    ];

    services = {
        gnome-keyring.enable = true;
        gpg-agent = {
            enable = true;
            defaultCacheTtl = 1800;
            enableSshSupport = true;
        };
    };
    programs.gpg.enable = true;

    home.packages = with stable; [
        # unstable
        pkgs.vscodium

        # non-work apps
        spotify
        signal-desktop
        discord
        telegram-desktop
        obsidian

        # rust
        rustc
        cargo

        # console utils
        tcpdump
        xclip
        yt-dlp

        # dev tools
        doctl
        ngrok
        
        # work apps
        slack

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
            enableBashIntegration = true;
            nix-direnv.enable = true;
        };

        bash = {
            enable = true;
            shellAliases = {
                ll = "ls -l";
                rebuild = "sudo nixos-rebuild switch --flake ~/zakrok_repo/nixos_config/flake.nix#laptop";
                dockerb = "docker-compose up -d --build";
                cds = "cd ~/zakrok_repo/nixos_config";
                clear_garbage = "";
                clip = "xclip -sel clip";
		        gs = "git status";
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

        # sign this please
        git = {
            enable=true;
            userName = "Zakrok09";
            userEmail = "31936449+Zakrok09@users.noreply.github.com";

            extraConfig = {
                commit.gpgsign = true;
                tag.gpgSign = true;
                user.signingkey = "04237EDFB8269F3A";
            };
        };
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}

