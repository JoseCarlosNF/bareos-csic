# Bareos Web-ui Dockerfile
FROM alpine:edge

LABEL maintainer="joseferreira@ufpa.br"

ENV TZ=America/Belem

# Packages required
RUN apk add --no-cache \
        bareos-webui-nginx \
        php7-fpm \
        tzdata

# Set timezone
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ >  /etc/timezone && \
    apk del tzdata

# Set environment to bareos-webui
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod u+x /docker-entrypoint.sh

# Run entrypoint
RUN mkdir /run/nginx \
 && chown nginx:nginx /run/nginx

EXPOSE 9100

VOLUME /etc/bareos-webui

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
