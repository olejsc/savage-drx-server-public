FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        ca-certificates \
        coreutils \
        gdb \
        libcurl4-gnutls-dev \
        libphysfs-dev \
        zip \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/local/ssl \
    && ln -sfn /etc/ssl/certs /usr/local/ssl/certs

WORKDIR /opt/savage-drx

COPY . .

RUN sed -i 's/\r$//' ./*.sh \
    && find game/mods/master game/script/summoner_arc -type f \( -name '*.cfg' -o -name '*.object' -o -name '*.objlist' \) -exec sed -i 's/\r$//' {} + \
    && chmod +x ./*.sh \
    && rm -rf /tmp/summoner-arc-package \
    && mkdir -p /tmp/summoner-arc-package/mods/master /tmp/summoner-arc-package/script \
    && cp game/mods/master/summoner_arc.cfg /tmp/summoner-arc-package/mods/master/summoner_arc.cfg \
    && cp -R game/script/summoner_arc /tmp/summoner-arc-package/script/summoner_arc \
    && (cd /tmp/summoner-arc-package && zip -qr /opt/savage-drx/game/summoner_arc.s2z mods script) \
    && rm -rf /tmp/summoner-arc-package \
    && rm -rf game/world \
    && mkdir -p game/world /drx

VOLUME ["/drx"]

EXPOSE 11235/tcp
EXPOSE 11235/udp

CMD ["./start_server.sh"]
