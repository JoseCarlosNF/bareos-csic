# Bareos director Dockerfile
FROM alpine:edge

LABEL maintainer="joseferreira@ufpa.br"

ENV TZ=America/Belem

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

SHELL ["/bin/ash", "-eou", "pipefail", "-c"]

# Packages required
RUN apk add --no-cache \
    bareos-mysql \
    mysql-client \
    curl \
    tzdata \
    tar

# Set enviroment to start bareos-dir
RUN mkdir /run/bareos \
 && chown bareos:bareos /run/bareos

COPY bareos-dir.tgz /bareos-dir.tgz
RUN tar xzf /bareos-dir.tgz -C /etc/bareos/

# Webhook - Notifications from telegram/slack
COPY webhook-notify /usr/local/bin/webhook-notify
RUN chmod u+x /usr/local/bin/webhook-notify


# Run entrypoint
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod u+x /docker-entrypoint.sh

EXPOSE 9101

VOLUME /etc/bareos
VOLUME /var/lib/bareos

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/bareos-dir", "-u", "bareos", "-f"]
