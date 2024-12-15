{ config, pkgs, stable, lib, inputs, ... }:

{
    # Home Manager needs a bit of information about you and the paths it should
    home = {
        username = "joan";
        homeDirectory = "/home/joan";
        stateVersion = "24.05";
    };

    imports = [
        ../../modules/home-manager/gnome-manage.nix
        ../../modules/home-manager/alacritty.nix
    ];

    home.packages = with stable; [
        vscodium

        xclip
        tcpdump
        
        doctl
        
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
    };
    
    programs.home-manager.enable = true;
}