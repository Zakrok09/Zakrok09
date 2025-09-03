{
    description = "My system in a flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

        home-manager = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        hyprland.url = "github:hyprwm/Hyprland";
    };


    # outputs
    outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ...}@inputs:
    let
        system = "x86_64-linux";

        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
        };

        # also put stable packages
        stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
        };

    in {
        nixosConfigurations = {
            default = nixpkgs.lib.nixosSystem {
                specialArgs = {
                    inherit system;
                    inherit pkgs;
                    inherit stable;   # pass it down the function
                    inherit inputs;
                };

                modules = [
                    ./host/default/configuration.nix
                    inputs.home-manager.nixosModules.default
                ];
            };
	        laptop = nixpkgs.lib.nixosSystem {
                specialArgs = {
                    inherit system;
                    inherit pkgs;
                    inherit stable;
                    inherit inputs;
                };

                modules = [
                    ./host/laptop/configuration.nix
                    inputs.home-manager.nixosModules.default
                ];
            };
        };
    };
}
