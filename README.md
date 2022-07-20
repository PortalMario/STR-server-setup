# Automated Skyrim Together Reborn Linux Server Setup for Ubuntu

## 0. Configure a static IP-Address on the server.
Edit `/etc/netplan/*.yaml`

Reference: https://netplan.io/examples

## 1. Run setup.sh.
As root, run: `bash setup.sh`

## 2. Configure Server.
After the command is finished, head to `/opt/docker/skyrimserver/config` to configure your server.
Configuration Reference: 
https://wiki.tiltedphoques.com/tilted-online/guides/server-guide/server-configuration 

## 3. Configure Port Forwarding on your router.
Internal Port: 10578

External Port: 10578

Server IP-Address: Will be shown during setup.sh

## 4. Start the game server again.
Start the server with: `docker start skyrimserver`

## 5. Let friends connect.
Follow this guide: https://wiki.tiltedphoques.com/tilted-online/guides/client-setup/using-modorganizer2-mo2/playing-skyrim-together-reborn/connecting-to-a-server

The Server IP-Address that your friends need will be shown during setup.sh

## Useful Commands
### Show Public IP
Sometmes ISPs will change your public ip-address over night. To find your new public ip-address, run: `curl -4 icanhazip.com`
### Start/Stop Server
`docker start skyrimserver`

`docker stop skyrimserver`

### Show Logs
`docker logs -tf "skyrimserver"`

## Recommended server specs
```
Ubuntu Server 22.04 LTS
4 Cores
6 GB RAM
80 GB Disk-Space
```

# Credits & Sources
Commands, guidelines and other information are extracted/gathered from the offical Skyrim Together Reborn website:
https://skyrim-together.com/

Docs: https://wiki.tiltedphoques.com/tilted-online/

All possible rights belong to them.