# Minecraft Dedicated Server in Docker

Minecraft is a sandbox that allows players to build with a variety of different blocks in a 3D procedurally generated
world, requiring creativity from players. Other activities in the game include exploration, resource gathering,
crafting, and combat. Multiple gameplay modes are available, including a survival mode in which the player must acquire
resources to build the world and maintain health, a creative mode where players have unlimited resources to build with
and the ability to fly, an adventure mode where players can play custom maps created by other players with certain
restrictions, a spectator mode where players can freely move throughout a world without being allowed to destroy or
build anything and be affected by gravity and collisions, and a hardcore mode, where the player is given only one chance
and the game difficulty is locked on hard (if they die, the world is deleted). The PC (Java) version of the game allows
players to create mods with new gameplay mechanics, items, and assets.

![Minecraft Screenshot](https://raw.githubusercontent.com/LacledesLAN/gamesvr-minecraft/master/.misc/screenshot1.jpg "Minecraft Screenshot")

This repository is maintained by [Laclede's LAN](https://lacledeslan.com). Its contents are intended to be bare-bones
and used as a stock server. If any documentation is unclear or it has any issues please see [CONTRIBUTING.md](./CONTRIBUTING.md).

## Linux Java Container

[![java linux/amd64](https://github.com/LacledesLAN/gamesvr-minecraft/actions/workflows/build-linux-java-image.yml/badge.svg?branch=master)](https://github.com/LacledesLAN/gamesvr-minecraft/actions/workflows/build-linux-java-image.yml)

### Download

```shell
docker pull lacledeslan/gamesvr-minecraft:java;
```

### Run Self Tests

The image includes a test script that can be used to verify its contents. No changes or pull-requests will be accepted
to this repository if any tests fail.

```shell
docker run --rm lacledeslan/gamesvr-minecraft:java ./ll-tests/gamesvr-java-minecraft.sh
```

### Run Interactive Server

```shell
docker run -d --rm -p 25565:25565 lacledeslan/gamesvr-minecraft:java java -Xms512M -Xmx1024M -jar /app/minecraft-server.jar nogui
```

## Linux Bedrock Container

### Download

```shell
docker pull lacledeslan/gamesvr-minecraft:bedrock;
```

### Run Self Tests

The image includes a test script that can be used to verify its contents. No changes or pull-requests will be accepted
to this repository if any tests fail.

```shell
docker run --rm lacledeslan/gamesvr-minecraft:bedrock ./ll-tests/gamesvr-bedrock-minecraft.sh
```

### Run Interactive Server

```shell
docker run -d --rm -p 19132-19133:19132-19133 lacledeslan/gamesvr-minecraft:bedrock ./bedrock_server
```

## Getting Started with Game Servers in Docker

[Docker](https://docs.docker.com/) is an open-source project that bundles applications into lightweight, portable,
self-sufficient containers. For a crash course on running Dockerized game servers check out [Using Docker for Game
Servers](https://github.com/LacledesLAN/README.1ST/blob/master/GameServers/DockerAndGameServers.md). For tips, tricks,
and recommended tools for working with Laclede's LAN Dockerized game server repos see the guide for [Working with our
Game Server Repos](https://github.com/LacledesLAN/README.1ST/blob/master/GameServers/WorkingWithOurRepos.md). You can
also browse all of our other Dockerized game servers: [Laclede's LAN Game Servers Directory](https://github.com/LacledesLAN/README.1ST/tree/master/GameServers).
