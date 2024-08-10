{
    inputs, config, pkgs, stable, lib, ...
}: {
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    
    services.udev.packages = [ 
        pkgs.gnome.gnome-settings-daemon 
    ];

    environment.gnome.excludePackages = (with pkgs; [
        # for packages that are pkgs.*
        gnome-tour                  # tour thing 
        gnome-connections           #
        epiphany                    # web browser
        geary                       # email reader
        evince                      # document viewer
    ]) ++ (with pkgs.gnome; [
        # for packages that are pkgs.gnome.*
    ]);


    # EXTENSIONS
    environment.systemPackages = with pkgs.gnomeExtensions; [
        vitals
        clipboard-indicator
        appindicator
    ];

}