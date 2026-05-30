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
    && find game/mods/master game/script/summoner_arc serverside-mods/human-silo clientside-mods/savage002-human-silo -type f \( -name '*.cfg' -o -name '*.object' -o -name '*.objlist' \) -exec sed -i 's/\r$//' {} + \
    && chmod +x ./*.sh \
    # && rm -rf /tmp/summoner-arc-package \
    # && mkdir -p /tmp/summoner-arc-package/mods/master /tmp/summoner-arc-package/script \
    # && cp game/mods/master/summoner_arc.cfg /tmp/summoner-arc-package/mods/master/summoner_arc.cfg \
    # && cp -R game/script/summoner_arc /tmp/summoner-arc-package/script/summoner_arc \
    # && (cd /tmp/summoner-arc-package && zip -qr /opt/savage-drx/game/summoner_arc.s2z mods script) \
    # && rm -rf /tmp/summoner-arc-package \
    # && rm -rf /tmp/rebalance-package \
    # && mkdir -p /tmp/rebalance-package/mods/master /tmp/rebalance-package/gui/standard \
    # && cp game/mods/master/rebalance.cfg /tmp/rebalance-package/mods/master/rebalance.cfg \
    # && cp Clientside/gui/standard/ui_tithe.cfg /tmp/rebalance-package/gui/standard/ui_tithe.cfg \
    # && cp Clientside/gui/standard/frame_event.cfg /tmp/rebalance-package/gui/standard/frame_event.cfg \
    # && cp Clientside/gui/standard/frame_event.cfg /tmp/rebalance-package/frame_event.cfg \
    # && sed -i 's/\r$//' /tmp/rebalance-package/mods/master/rebalance.cfg /tmp/rebalance-package/gui/standard/ui_tithe.cfg /tmp/rebalance-package/gui/standard/frame_event.cfg /tmp/rebalance-package/frame_event.cfg \
    # && (cd /tmp/rebalance-package && zip -qr /opt/savage-drx/game/rebalance.s2z mods gui frame_event.cfg) \
    # && (cd /tmp/rebalance-package && zip -qr /opt/savage-drx/game/savage1.s2z gui frame_event.cfg) \
    # && rm -rf /tmp/rebalance-package \
    && rm -rf game/script/human_silo \
    && mkdir -p game/mods/master game/script \
    && cp serverside-mods/human-silo/mods/master/human_silo.cfg game/mods/master/human_silo.cfg \
    && cp -R serverside-mods/human-silo/script/human_silo game/script/human_silo \
    && rm -rf /tmp/human-silo-server-package /tmp/human-silo-client-package \
    && mkdir -p /tmp/human-silo-server-package /tmp/human-silo-client-package \
    && cp -R serverside-mods/human-silo/. /tmp/human-silo-server-package/ \
    && cp -R clientside-mods/savage002-human-silo/. /tmp/human-silo-client-package/ \
    && (cd /tmp/human-silo-server-package && zip -qr /opt/savage-drx/game/human_silo.s2z mods script) \
    && (cd /tmp/human-silo-client-package && zip -qr /opt/savage-drx/game/savage002.s2z gui mods script) \
    && rm -rf /tmp/human-silo-server-package /tmp/human-silo-client-package \
    && rm -rf game/world \
    && mkdir -p game/world /drx

VOLUME ["/drx"]

EXPOSE 11235/tcp
EXPOSE 11235/udp

CMD ["./start_server.sh"]
