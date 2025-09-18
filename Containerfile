FROM alpine:edge

LABEL maintainer="Efim Ishenin <me@efima.ru>" \
      org.opencontainers.image.title="tor" \
      org.opencontainers.image.description="Tor with bridges" \
      org.opencontainers.image.source="https://github.com/Efimish/tor-container" \
      org.opencontainers.image.licenses="MIT"

RUN echo 'https://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    apk upgrade && \
    apk add tor lyrebird webtunnel curl && \
    chmod 700 /var/lib/tor && \
    rm -rf /var/cache/apk/*

HEALTHCHECK --timeout=10s --start-period=60s \
  CMD curl -fIL --socks5-hostname 127.0.0.1:9050 'http://2gzyxa5ihm7nsggfxnu52rck2vv4rvmdlkiu3zzui5du4xyclen53wid.onion/robots.txt' || exit 1

USER tor
EXPOSE 9050/tcp

CMD ["/usr/bin/tor", "-f", "/etc/tor/torrc"]
