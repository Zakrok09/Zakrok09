{
    description = "My system in a flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

        home-manager = {
            url = "github:nix-community/home-manager/release-24.11";
            inputs.nixpkgs.follows = "nixpkgs-stable";
        };

        hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };


    # outputs
    outputs = { self, nixpkgs, nixpkgs-stable, home-manager, hyprland, ...}@inputs:
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
                    inputs.home-manager.nixosModules.laptop
                ];
            };
        };

        homeConfigurations = {
            eccyboo = home-manager.lib.homeManagerConfiguration {
                specialArgs = {
                    inherit system;
                    inherit pkgs;
                    inherit stable;   # pass it down the function
                    inherit inputs;
                };
                modules = [
                    ./host/default/home.nix
                ];
            };
        };
    };
}
