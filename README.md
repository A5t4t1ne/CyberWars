# Cyber Wars

This repo is meant to contain everything CTF-environment-related. 

## Installation

Everything needed to create the CTF environment is inside the docker containers. So you should be able to start and build it with docker-compose and everything should be up and running.

### Prerequisites

- Docker
- Docker-compose

### Docker environment

Download the repo, build and start the environment:

```
git clone https://github.com/A5t4t1ne/CyberWars.git
cd CyberWars/docker_stuff
docker-compose up -d --build
```

### Automatic environment start

**For an Arch host system**: \
In order to start the CTF environment automatically after boot, you have to register a service.

```bash
sudo cp start_ctf.service /etc/systemd/system/
sudo chmod 644 /etc/systemd/system/start_ctf.service 
sudo systemctl daemon-reload
sudo systemctl enable start_ctf.service 
```

Start the service now (and therefore the environment): 
```bash 
sudo systemctl start start_ctf.service 
```

**Every other host system**:\
Idk, look it up. I'm sure you will figure something out.
