# escape=`
FROM lacledeslan/steamcmd:linux as DOWNLOADER

RUN curl -sSL "https://launcher.mojang.com/v1/objects/c9df48efed58511cdd0213c56b9013a7b5c9ac1f/server.jar" -o /output/minecraft-server.jar &&`
    echo "c9df48efed58511cdd0213c56b9013a7b5c9ac1f /output/minecraft-server.jar" | sha1sum -c -;

FROM eclipse-temurin:20-jdk as BUILDER

COPY --chown=Minecraft:root --from=DOWNLOADER /output/minecraft-server.jar /output/minecraft-server.jar

# Build custom JRE
RUN jlink --no-header-files --no-man-pages --compress=2 --strip-debug --add-modules java.compiler,java.desktop,java.management,java.naming,java.rmi,java.scripting,java.sql,jdk.sctp,jdk.unsupported,jdk.zipfs --output /output/jre

FROM debian:bullseye-slim

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

COPY --chown=Minecraft:root --from=BUILDER /output/jre /app/jre

ENV PATH "/app/jre/bin/:$PATH"

COPY --chown=Minecraft:root ./dist/all /app

COPY --chown=Minecraft:root ./dist/linux/ll-tests/gamesvr-java-minecraft.sh /app/ll-tests/gamesvr-java-minecraft.sh

RUN chmod +x /app/*.jar /app/ll-tests/*.sh;

USER Minecraft

WORKDIR /app

ONBUILD USER root
