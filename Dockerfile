FROM nginx:1.13.1-alpine
MAINTAINER Karsten Kaj Jakobsen <karsten@karstenjakobsen.dk>

ENV VIRTUAL_HOST static.example.com
ENV VIRTUAL_PORT 8080

RUN mkdir -p /var/www/static/

COPY config/default.conf.template /default.conf.template
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT [ "/entrypoint.sh" ]