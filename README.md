# mlat-client

[![Release](https://github.com/flighttrackr/docker-mlat-client/actions/workflows/release.yml/badge.svg)](https://github.com/flighttrackr/docker-mlat-client/actions/workflows/release.yml)

This project makes [wiedehopf]'s [mlat-client] software available as a Docker image.

Due to the API limitations of Docker Hub, we use GitHub as container image registry.

## Other projects

We have other Flighttracking projects, check our [GitHub profile].

## Supported architectures

- linux/amd64
- linux/arm/v6
- linux/arm/v7
- linux/arm64
- linux/386

## Run container

```shell
docker run \
  -it --rm \
  ghcr.io/flighttrackr/mlat-client:latest
```

## Environment variables

| Environment variable | Required | Default | Description |
| :- | :-: | :- | :- |
| INPUT_TYPE | x | auto | Input type: `auto`, `dump1090`, `beast`, `radarcape_12mhz`, `radarcape_gps`, `radarcape`, `sbs`, `avrmlat` |
| INPUT_CONNECT_HOST | x | | Input host to connect to for Mode S traffic |
| INPUT_CONNECT_PORT | x | 30002 | Input port to connect to for Mode S traffic |
| RESULTS | | | `<protocol>,connect,<host:port>` or `<protocol>,listen,<port>`<br>Protocol: `basestation`, `ext_basestation`, `beast` |
| NO_ANON_RESULTS | |  no | No results for anonymized aircraft: `yes`, `no` |
| NO_MODEAC_RESULTS | | no | No results for Mode A/C tracks: `yes`, `no` |
| LAT | x | | Latitude of receiver |
| LON | x | | Longitude of receiver |
| ALT | x | | Altitude of receiver (in `m` or `ft`) |
| PRIVACY | | no | Sets the privacy flag for this receiver: `yes`, `no` |
| USER | x | | User information to give to the server |
| SERVER_HOST | x | feed.adsbexchange.com | Host of the multilateration server to connect to |
| SERVER_PORT | x | 31090 | Port of the multilateration server to connect to |
| NO_UDP | | no | Don't offer to use UDP transport for sync/mlat messages: `yes`, `no` |
| UUID_FILE | | | Filepath of a file containing the UUID (has lower priority than `UUID`) |
| UUID | | | UUID string (has higher priority than `UUID_FILE`) |
| LOG_TIMESTAMPS | | no | Print timestamps in logging output: `yes`, `no` |


[wiedehopf]: https://github.com/wiedehopf
[mlat-client]: https://github.com/wiedehopf/mlat-client
[GitHub profile]: https://github.com/flighttrackr
[entrypoint.sh]: ./entrypoint.sh
[Dockerfile]: ./Dockerfile
