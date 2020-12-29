# Dockerfile Bareos storage daemon
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

# Package required
RUN apk add --no-cache bareos

# Set environment to bareos-sd
RUN mkdir /run/bareos \
 && chown bareos:bareos /run/bareos

COPY bareos-sd.tgz /bareos-sd.tgz
RUN tar xzf /bareos-sd.tgz -C /etc/bareos/

# Run entrypoint
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod u+x /docker-entrypoint.sh

EXPOSE 9103

VOLUME /etc/bareos
VOLUME /var/lib/bareos/storage

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/bareos-sd", "-u", "bareos", "-f"]
