{
    config, pkgs, stable, lib, inputs, ...
}: {
    programs.bash = {
        enable = true;
        shellAliases = {
            ll = "ls -l";
            rebuild-default = "sudo nixos-rebuild switch --flake ~/zakrok_repo/nixos_config#default";
            rebuild-laptop = "sudo nixos-rebuild switch --flake ~/zakrok_repo/nixos_config#laptop";
            dockerb = "docker-compose up -d --build";
            cds = "cd ~/zakrok_repo/nixos_config";
            clear_garbage = "";
            clip = "xclip -sel clip";
            gs = "git status";
        };
    };
}
