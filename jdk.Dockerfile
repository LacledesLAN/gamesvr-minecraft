# THIS DOCKERFILE IS NOT KEPT UP TO DATE - IT EXISTS AS A BACKUP. USE `linux.Dockerfile` INSTEAD.

# escape=`
FROM lacledeslan/steamcmd:linux as DOWNLOADER

RUN curl -sSL "https://launcher.mojang.com/v1/objects/125e5adf40c659fd3bce3e66e67a16bb49ecc1b9/server.jar" -o /output/minecraft-server.jar &&`
    echo "125e5adf40c659fd3bce3e66e67a16bb49ecc1b9 /output/minecraft-server.jar" | sha1sum -c -;

FROM openjdk:20-slim

ARG BUILDNODE=unspecified
ARG SOURCE_COMMIT=unspecified

HEALTHCHECK NONE

RUN apt-get update && apt-get install -y `
         locales locales-all tmux &&`
    apt-get clean &&`
    echo "LC_ALL=en_US.UTF-8" >> /etc/environment &&`
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*;

ENV LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

LABEL com.lacledeslan.build-node=$BUILDNODE `
      org.label-schema.schema-version="1.0" `
      org.label-schema.url="https://github.com/LacledesLAN/README.1ST" `
      org.label-schema.vcs-ref=$SOURCE_COMMIT `
      org.label-schema.vendor="Laclede's LAN" `
      org.label-schema.description="Minecraft (Java) Dedicated Server in Docker" `
      org.label-schema.vcs-url="https://github.com/LacledesLAN/gamesvr-minecraft"

# Set up Enviornment
RUN useradd --home /app --gid root --system Minecraft &&`
    mkdir --parents /app &&`
    chown Minecraft:root -R /app;

COPY --chown=Minecraft:root --from=DOWNLOADER /output/minecraft-server.jar /app/minecraft-server.jar

COPY --chown=Minecraft:root ./dist/all /app

COPY --chown=Minecraft:root ./dist/linux /app

RUN chmod +x /app/*.jar /app/ll-tests/*.sh;

USER Minecraft

WORKDIR /app

ONBUILD USER root
