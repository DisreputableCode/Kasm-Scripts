#!/bin/bash

# Had issues with msfdb init when running Kali in Kasm, as the script must be using systemctl commands,
# which are not available in Kasm containers. 
# ERROR: "System has not been booted with systemd as init system (PID 1). Can't operate."
#
# This script installs postgresql, starts the service, and runs the msfdb reinit command to init the database.
#
# If you don't have a folder mapped to the image, create a folder and map. E.g;
#   sudo mkdir /var/kasm_shares/kali
#   sudo chown 1000:1000 /var/kasm_shares/kali
# Add volume mapping in Kali Kasm image settings. E.g;
#   {"/var/kasm_shares/kali":
#       {
#       "bind":"/share",
#       "gid":1000,
#       "uid":1000,
#       "mode":"rw",
#       "required":true,
#       "skip_check":false,
#       }
#   }
# Copy this file to the share, chmod +x to make executable
#
# Run the script in lieu of 'msfdb init'. E.g;
#   sudo /share/msfdb_init.db

# install postgresql
apt install postgresql postgresql-contrib -y
# start postgresql (without systemd)
service postgresql start
# use reinit as db service already running
# ignore errors on output, db should be running and initialised
msfdb reinit
