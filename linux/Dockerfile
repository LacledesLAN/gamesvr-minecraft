# escape=`
FROM openjdk:11-jre

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

COPY --chown=Minecraft:root eula.txt /app/eula.txt

COPY --chown=Minecraft:root ./ll-tests /app/ll-tests

RUN chmod +rx /app/ll-tests/*.sh &&`
    chmod +rwx -R /app &&`
    chown Minecraft:root -R /app/ll-tests;

USER Minecraft

RUN curl -sSL "https://launcher.mojang.com/v1/objects/3737db93722a9e39eeada7c27e7aca28b144ffa7/server.jar" -o /app/minecraft-server.jar &&`
    echo "3737db93722a9e39eeada7c27e7aca28b144ffa7 /app/minecraft-server.jar" | sha1sum -c - && `
    chmod +rwx /app/*.jar;

WORKDIR /app

ONBUILD USER root
