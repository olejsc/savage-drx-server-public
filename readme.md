## Docker LAN Server

This repository can run the dedicated server in Docker and expose it on the local network on port `11235`.

Prerequisites:
- Docker Desktop or Rancher Desktop is installed and running with a Docker-compatible daemon.
- The maps repository exists at `C:\Users\ole_j\source\repos\savage-drx-maps`.

Prepare a local config:
```powershell
Copy-Item .\config\config_local.example.ini .\config\config_local.ini
```

Edit `config/config_local.ini` and set `svr_hostname` to this Windows host's LAN IPv4 address. For LAN-only testing, keep:
```ini
svr_broadcast = 0
svr_port = 11235
SKIP_MAP_CHECK = 1
```

Start the server:
```powershell
docker-compose up --build
```

If your Docker installation provides the newer Compose v2 plugin, `docker compose up --build` is equivalent. This machine currently exposes Compose as `docker-compose`.

The Compose setup mounts `C:\Users\ole_j\source\repos\savage-drx-maps` into `/opt/savage-drx/game/world`, persists server state/logs in the Docker volume `drx-data`, and publishes both UDP and TCP port `11235`.

During the Docker build, the unpacked Summoner Arc files under `game/mods/master/summoner_arc.cfg` and `game/script/summoner_arc/` are packaged into `game/summoner_arc.s2z` so the server can advertise the mod archive to clients.

If the game client does not show the server in its browser, first test a direct connection to `<windows-host-lan-ip>:11235`. Also ensure Windows Firewall allows inbound UDP `11235`.

## Initial Setup:
1. **Clone the Repositories**  
Clone the main server repository and the maps repository:
```bash
git clone https://github.com/savage-drx/savage-drx-server-public.git
git clone https://github.com/savage-drx/savage-drx-maps.git
```

Ensure that both `savage-drx-server-public` and `savage-drx-maps` are located at the same directory level.  
Verify that the `world` symlink in the server project correctly points to the `maps` repository:
```bash
world -> ../../savage-drx-maps/
```

2. **Register Your Server**  
Go to https://savagedrx.com/user/servers and register your server.  
> Note: This functionality is available only for users in the `USER_REGULAR` group. New users are assigned to the `USER_NEWCOMER` group by default.

3. **Configure Your Server**  
Update `config.ini` with your credentials
- `sv_authid` your server ID from the registration step
- `sv_authtoken` your server token
- `svr_hostname` your public IP address or hostname  

4. **Optional settings**:  
- `svr_broadcast` set to `1` to make your server visible in the global server list. This is optional for local or testing servers.  
- `svr_name` set your server name.  
- `sv_motd1` to `sv_motd6` set your message of the day lines.  
-  any other additional configuration values as needed.

5. **Prepare your environment**  
   Run `install_dependencies.sh`

6. **Run the Server**  
Use the provided `start_server.sh` or `start_server_nohup.sh` script to launch your server.  

7. **Running Multiple Game Servers**  
Create and use a copy of the `shell` script together with its own `custom_config.ini` for each server

8. **Accessing Logs and Config Files**  
Server logs and temporary configuration files will be available in the `/drx` directory (by default).

