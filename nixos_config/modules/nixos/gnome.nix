{
    inputs, config, pkgs, stable, lib, ...
}: {
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;


    environment.gnome.excludePackages = (with pkgs; [
        # for packages that are pkgs.*
        gnome-tour
        gnome-connections
    ]) ++ (with pkgs.gnome; [
        # for packages that are pkgs.gnome.*
        epiphany # web browser
        geary # email reader
        evince # document viewer
    ]);


    environment.systemPackages = with pkgs.gnomeExtensions; [
        vitals
        clipboard-indicator
    ];

}