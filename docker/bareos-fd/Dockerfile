# Dockerfile Bareos client/file daemon
FROM alpine:edge

LABEL maintainer="joseferreira@ufpa.br"

ARG BUILD_DATE
ARG NAME
ARG VCS_REF
ARG VERSION

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name=$NAME \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.original-repo="https://github.com/barcus/bareos" \
      org.label-schema.repository="https://github.com/josecarlosnf/bareos-csic" \
      org.label-schema.version=$VERSION

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

# Packages required
RUN apk add --no-cache \
    bareos \
    openssh-client

# Set environment to start bareos-fd
RUN mkdir /run/bareos \
 && chown bareos:bareos /run/bareos

# Run entrypoint
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod u+x /docker-entrypoint.sh

EXPOSE 9102

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/bareos-fd", "-u", "bareos", "-f"]
