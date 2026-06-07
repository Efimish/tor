# Tor with bridges alpine image

## Pull and run image

```bash
docker run --name tor -d -p 127.0.0.1:9050:9050/tcp --restart unless-stopped ghcr.io/efimish/tor
```

## Generate vanity onion address

```bash
docker run --rm -it -v ./keys:/keys ghcr.io/cathugger/mkp224o:master -d /keys your_address_here
```
