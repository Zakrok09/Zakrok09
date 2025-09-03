{
    config, pkgs, stable, lib, inputs, ...
}: {

    # downlaod the package
    home.packages = with pkgs; [ alacritty ];


    programs = {
        alacritty = {
            enable = true;
            settings = {
                window = {
                    opacity = 0.9;
                };

                colors.primary = {
                    background = "#101113";
                };

                colors.normal = {
                    green = "#81a2be";
                };

                keyboard.bindings = [
                    {
                        key = "Return";
                        mods = "Super|Control";
                        action = "SpawnNewInstance";
                    }
                    {
                        key = "*";
                        mods = "Control";
                        action = "ResetFontSize";
                    }
                ];
            };
        };
    };
}
