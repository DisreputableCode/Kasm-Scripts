# Kasm Scripts
Collection of scripts to make working in Kasm a little easier.

## msfdb_init.sh
I run into issues with 'msfdb init' when running Kali in Kasm, as the script must be using systemctl commands which are not available in Kasm containers. 
(ERROR: "System has not been booted with systemd as init system (PID 1). Can't operate")

This script installs postgresql, starts the service, and runs the msfdb reinit command to init the database.

If you don't have a folder mapped to the image, create a folder and map (so the script is always available).
E.g.
``` bash
sudo mkdir /var/kasm_shares/kali
sudo chown 1000:1000 /var/kasm_shares/kali # set owner and group, to match volume mapping settings
```
Add volume mapping in Kali Kasm image settings. E.g;
``` json
{"/var/kasm_shares/kali":
    {
    "bind":"/share",
    "gid":1000,
    "uid":1000,
    "mode":"rw",
    "required":true,
    "skip_check":false,
    }
}
```
Copy this file to the share, chmod +x to make executable
Run the script in lieu of 'msfdb init'. E.g;
``` bash
sudo /share/msfdb_init.db
```