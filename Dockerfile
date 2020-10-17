FROM ubuntu:bionic

ENV CPU_MHZ="1000.00"
ENV STEAM_USER=anonymous
ENV STEAM_PASSWORD=
ENV INSTALL_PATH=/Steam/steamapps
ENV APP_ID=

RUN apt update \
    && apt install -y software-properties-common \
    && add-apt-repository multiverse \
    && dpkg --add-architecture i386 \
    && apt update \
    && apt install -y lib32gcc1 curl

WORKDIR /Steam
RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

ENTRYPOINT ./steamcmd.sh \
            +@sSteamCmdForcePlatformType windows \
            +login ${STEAM_USER:=anonymous} ${STEAM_PASSWORD} \
            +force_install_dir $INSTALL_PATH \
            +app_update $APP_ID \
            +quit
