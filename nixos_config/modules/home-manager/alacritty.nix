{
    config, pkgs, stable, lib, inputs, ...
}: {

    # downlaod the package
    home.packages = with pkgs; [ alacritty ];


    programs = {
        alacritty = {
            enable = true;
            settings = {
                font.normal = {
                    family = "monospace";
                    style = "JetBrainsMono";
                };

                colors.primary = {
                    background = "#101113";
                }
            };
        };
    };
}