{inputs, config, pkgs, hyprland, lib, ...}:
{
    options = {
        wallpaper = lib.mkOption {
            default = ./nixoswallpaper.jpg;
            type = lib.types.path;
            description = ''
                Path to hyprpaper wallpaper source
            '';
        };
    };

    config = {
        home.packages = with pkgs; [
            # hyprland
            networkmanagerapplet
            waybar
            rofi-wayland
            dunst
            libnotify
            hyprpaper
        ];

        home.pointerCursor = {
            gtk.enable = true;
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Classic";
            size = 16;
        };

#        gtk = {
#            enable = true;
#            theme = {
#                package = pkgs.flat-remix-gtk;
#                name = "Flat-Remix-GTK-Grey-Darkest";
#            };
#
#            iconTheme = {
#                package = pkgs.gnome.adwaita-icon-theme;
#                name = "Adwaita";
#            };
#
#            font = {
#                name = "Sans";
#                size = 11;
#            };
#        };

        # cachix the hyprland build

        home.file = {

            # HYPRPAPER
            ".config/hypr/hyprpaper.conf".text = ''
                preload = ${config.wallpaper}
                wallpaper = ${config.wallpaper}
            '';
        };

        wayland.windowManager.hyprland = {
            enable = true;
            package = inputs.hyprland.packages."${pkgs.system}".hyprland;

            settings = {
                "$mod" = "SUPER";
                "$terminal" = "alacritty";
                "$fm" = "nautilus";

                "exec-once" = [
                    "$terminal"
                    "nm-applet &"
                    "waybar & hyprpaper & librewolf"
                ];

                bindr = [
                    "$mod, SUPER_L, exec, pkill rofi || rofi -show drun -show-icons"
                ];

                bindm = [
                    "$mod, mouse:272, moveactive"
                    "$mod, mouse:273, resizeactive"
                    "$mod ALT, mouse:272, resizeactive"
                ];

                bind = [
                    "$mod, F, exec, librewolf"
                    "$mod, C, exec, $terminal"
                    "$mod, E, exec, $fm"
                    "$mod, M, exit"
                    "$mod, W, killactive"
                    "$mod, G, togglefloating"

                    "ALT, Tab, cyclenext"
                    "ALT SHIFT, Tab, cyclenext, prev"

                    # move focus
                    "$mod, left, movefocus, l"
                    "$mod, right, movefocus, r"
                    "$mod, up, movefocus, u"
                    "$mod, down, movefocus, d"

                    # workspces
                    "$mod, 1, workspace, 1"
                    "$mod, 2, workspace, 2"
                    "$mod, 3, workspace, 3"
                    "$mod, 4, workspace, 4"
                    "$mod, 5, workspace, 5"
                    "$mod, 6, workspace, 6"
                    "$mod, 7, workspace, 7"
                    "$mod, 8, workspace, 8"
                    "$mod, 9, workspace, 9"
                    "$mod, 10, workspace, 0"

                    "$mod SHIFT, 1, movetoworkspace, 1"
                    "$mod SHIFT, 2, movetoworkspace, 2"
                    "$mod SHIFT, 3, movetoworkspace, 3"
                    "$mod SHIFT, 4, movetoworkspace, 4"
                    "$mod SHIFT, 5, movetoworkspace, 5"
                    "$mod SHIFT, 6, movetoworkspace, 6"
                    "$mod SHIFT, 7, movetoworkspace, 7"
                    "$mod SHIFT, 8, movetoworkspace, 8"
                    "$mod SHIFT, 9, movetoworkspace, 9"
                    "$mod SHIFT, 10, movetoworkspace, 0"

                    "$mod SHIFT, right, workspace, e+1"
                    "$mod SHIFT, left, workspace, e-1"

                    "$mod SHIFT ALT, up, movewindow, mon:+1"
                    "$mod SHIFT ALT, down, movewindow, mon:-1"
                ];

                input = {
                    touchpad = {
                        natural_scroll = "true";
                    };
                };

                "monitor"="eDP-1,1920x1080@60,0x0,1.00";

                gestures = {
                    "workspace_swipe" = "true";
                    "workspace_swipe_fingers" = "4";
                };

                general={
                "gaps_in" = "5";
                "gaps_out" = "5";
                "border_size" = "2";
                };
            };
        };
    };
}
