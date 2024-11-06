# Cyber Wars

This repo is meant to contain everything CTF-environment-related. 

## Installation

Everything needed to create the CTF environment is inside the docker containers. So you should be able to start and build it with docker-compose and everything should be up and running.

### Prerequisites

- Docker
- Docker-compose

### Docker environment

Download the repo and start the environment:

```
git clone https://github.com/A5t4t1ne/CyberWars.git
cd CyberWars/docker_stuff
docker-compose up -d --build
```

Note that docker needs root-privileges.


### Automatic environment start

**For an Arch host system**: \
In order to start the CTF environment automatically after boot, you have to register a service.

```bash
sudo cp start_ctf.service /etc/systemd/system/
sudo chmod 644 /etc/systemd/system/start_ctf.service 
sudo systemctl daemon-reload
sudo systemctl enable start_ctf.service 
```

Manually start the service: 
```bash 
sudo systemctl start start_ctf.service 
```
