{
    inputs, config, pkgs, stable, lib, ...
}: {
    environment.systemPackages = [ pkgs.cifs-utils ];
    fileSystems."/mnt/share" = {
        device = "//192.168.178.146/share";
        fsType = "cifs";
        options = [
            "credentials=/home/eccyboo/.cifs-creds"
                #########################
                ###### File being #######
                #########################
                # username=<USERNAME>
                # domain=<DOMAIN>
                # password=<PASSWORD>
            "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users"
	    "uid=1000,gid=100"
        ];
    };
}
