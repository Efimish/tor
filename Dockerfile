FROM alpine:edge

LABEL maintainer="Efim Ishenin <efim.ishenin@gmail.com>" \
      org.opencontainers.image.title="tor" \
      org.opencontainers.image.description="Tor with bridges" \
      org.opencontainers.image.source="https://github.com/Efimish/tor" \
      org.opencontainers.image.licenses="MIT"

RUN echo 'https://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    apk upgrade && \
    apk add tor lyrebird webtunnel curl && \
    chmod 700 /var/lib/tor && \
    curl -fsSL https://raw.githubusercontent.com/igareck/vpn-configs-for-russia/refs/heads/main/TOR-BRIDGES/TOR_BRIDGES_WEBTUNNEL.txt | sed '/^#/d; /^\s*$/d; s/^/Bridge /' > /etc/tor/bridges.txt && \
    rm -rf /var/cache/apk/*

COPY torrc /etc/tor/torrc

HEALTHCHECK --timeout=10s --start-period=60s \
  CMD curl -fIL --socks5-hostname 127.0.0.1:9050 'http://2gzyxa5ihm7nsggfxnu52rck2vv4rvmdlkiu3zzui5du4xyclen53wid.onion/robots.txt' || exit 1

USER tor
EXPOSE 9050/tcp

CMD ["/usr/bin/tor", "-f", "/etc/tor/torrc"]
