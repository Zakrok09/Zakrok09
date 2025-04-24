{ config, pkgs, stable, lib, inputs, ... }:

{
    # Home Manager needs a bit of information about you and the paths it should
    home = {
        username = "eccyboo";
        homeDirectory = "/home/eccyboo";
        stateVersion = "25.05";
    };

    imports = [
        ../../modules/home-manager/gnome-manage.nix
        ../../modules/home-manager/alacritty.nix
        ../../modules/home-manager/bash.nix
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

    home.packages = with pkgs; [
	# work apps
        vscodium
	gimp

        # non-work apps
        spotify
        signal-desktop
        discord
        telegram-desktop
        obsidian
        prismlauncher
        obs-studio
        rhythmbox                                        # music player 
        gnome-obfuscate

        # console utils
        tcpdump
        xclip
        yt-dlp
	    tealdeer

        # dev tools
        doctl
	    qemu
	    quickemu
	    monero-cli
	    wireshark-qt
        
        # work apps
        slack

        # browsers
        stable.chromium

        #(nerd-fonts.override { fonts = [ "JetBrainsMono" ]; })
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

        librewolf = {
            enable = true;
            # Enable WebGL
            settings = {
                "webgl.disabled" = false;
                "identity.fxaccounts.enabled" = true;
            };
        };

        git = {
            enable=true;
            userName = "Zakrok09";
            userEmail = "31936449+Zakrok09@users.noreply.github.com";

            extraConfig = {
                # Sign all commits using ssh key
                commit.gpgsign = true;
                tag.gpgSign = true;
                user.signingkey = "86695D88CBBCCAEA";
            };
        };
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}

