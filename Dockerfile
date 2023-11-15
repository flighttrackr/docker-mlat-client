# Builder
FROM python:3.11.6-alpine3.18 AS builder

ARG UPSTREAM_REMOTE
ARG UPSTREAM_BRANCH
ARG UPSTREAM_COMMIT

# Packages
RUN apk add --no-cache build-base git

# Workdir
WORKDIR /app

# Environment
ENV PYTHONPATH="/app/python-packages/lib/python3.11/site-packages"

# Get mlat-client
RUN mkdir mlat-client && \
    cd mlat-client && \
    git clone -b ${UPSTREAM_BRANCH} ${UPSTREAM_REMOTE} . && \
    git -c advice.detachedHead=false checkout ${UPSTREAM_COMMIT} && \
    mkdir -p /app/python-packages && \
    python3 setup.py install --prefix=/app/python-packages

# Cleanup
RUN rm -rf /app/mlat-client/.git*


# Release
FROM python:3.11.6-alpine3.18 AS release

# Workdir
WORKDIR /app

# Packages
RUN apk add --no-cache bash

# Copy files
COPY --from=builder /app/python-packages /usr/local
COPY --from=builder /app/mlat-client/ /app/
COPY entrypoint.sh /entrypoint.sh

# Permissions
RUN chmod +x /entrypoint.sh mlat-client && \
    mkdir /app/data

# Environment
ENV INPUT_TYPE="auto" \
    INPUT_CONNECT_HOST="" \
    INPUT_CONNECT_PORT="30002" \
    RESULTS="" \
    NO_ANON_RESULTS="no" \
    NO_MODEAC_RESULTS="no" \
    LAT="" \
    LON="" \
    ALT="" \
    PRIVACY="no" \
    USER="" \
    SERVER_HOST="feed.adsbexchange.com" \
    SERVER_PORT="31090" \
    NO_UDP="no" \
    UUID_FILE="" \
    UUID="" \
    LOG_TIMESTAMPS="no"

# Entrypoint
ENTRYPOINT [ "/entrypoint.sh" ]

# Command
CMD [ "sh", "-c", "python3 mlat-client" ]
