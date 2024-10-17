FROM alpine:3.19


RUN apk update && apk upgrade && apk add --no-cache curl tar gzip && \
    mkdir -p /var/www/ && \
    mkdir -p /etc/sws/

COPY www/. /var/www/
COPY config/server_config.toml /etc/sws/
COPY tools/sws_install.sh /tmp/

WORKDIR /var/www/

RUN cat /tmp/sws_install.sh | SWS_INSTALL_DIR="/usr/bin" sh

RUN rm /tmp/sws_install.sh

EXPOSE 4242

CMD ["static-web-server", "-w", "/etc/sws/server_config.toml"]