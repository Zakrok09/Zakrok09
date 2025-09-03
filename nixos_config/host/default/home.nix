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

    # wayland + hyprland
    wayland.windowManager.hyprland = {
        enable = true;
        # set the flake package
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

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

        # hyprland
        wf-recorder
        wofi

        # console utils
        tcpdump
        xclip
        yt-dlp
	tealdeer

        # dev tools
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

    wayland.windowManager.hyprland.settings = {
        "$mod" = "SUPER";
        "$term" = "alacritty";
        "$fileManager" = "nautilus";
        "$menu" = "wofi --show drun";
	general = {
            gaps_in = 2;
            gaps_out = 2;
            border_size = 1;
        };
        bindm = [
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow" 
        ];
        bind = 
            [
                "$mod, L, exec, librewolf"
                "$mod, K, exec, $term"
                "$mod, Q, killactive,"
                "$mod, F, fullscreen, 0"
                "$mod SHIFT, F, fullscreen, 1"
                "$mod, Space, exec, toggle_float"
                "$mod, , exec, $menu || pkill wofi"

                #focusing
                "$mod, left, movefocus, l"
                "$mod, right, movefocus, r"
                "$mod, up, movefocus, u"
                "$mod, down, movefocus, d"

                #window control
                "$mod SHIFT, left, movewindow, l"
                "$mod SHIFT, right, movewindow, r"
                "$mod SHIFT, up, movewindow, u"
                "$mod SHIFT, down, movewindow, d"

                "$mod CTRL, left, resizeactive, -80 0"                
                "$mod CTRL, right, resizeactive, 80 0"                
                "$mod CTRL, up, resizeactive, 0 -80"                
                "$mod CTRL, down, resizeactive, 0 80"

                "$mod ALT, left, moveactive, -80 0"                
                "$mod ALT, right, moveactive, 80 0"                
                "$mod ALT, up, moveactive, 0 -80"                
                "$mod ALT, down, moveactive, 0 80"

                # using the mouse
                "$mod, mouse_down, workspace, e-1"
                "$mod, mouse_up, workspace, e+1"             
            ]
            ++ (
                # workspaces 
                builtins.concatLists (builtins.genList (i:
                    let ws = i + 1;
                    in [
                        "$mod, code:1${toString i}, workspace, ${toString ws}"
                        "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                    ]
                )
                9)
            );
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

        gpg.enable = true;

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

