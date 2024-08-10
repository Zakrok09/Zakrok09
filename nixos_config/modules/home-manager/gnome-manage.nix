{
    config, pkgs, stable, lib, inputs, ...
}: {
    dconf = {
        enable = true;
        settings = {
            "org/gnome/shell" = {
                disable-user-extensions = false; # enables user extensions
                enabled-extensions = [
                    pkgs.gnomeExtensions.vitals.extensionUuid
                    pkgs.gnomeExtensions.clipboard-indicator.extensionUuid
                    pkgs.gnomeExtensions.appindicator.extensionUuid
                ];
            };

            # Configure individual extensions
#            "org/gnome/shell/extensions/blur-my-shell" = {
#                brightness = 0.75;
#                noise-amount = 0;
#            };
        };
    };
}