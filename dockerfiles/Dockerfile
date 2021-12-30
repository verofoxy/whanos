FROM docker:dind

RUN apk add --update --no-cache bash tini

COPY ./dockerfiles/daemon.json  /etc/docker/daemon.json

COPY ./dockerfiles/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["tini", "--", "/entrypoint.sh"]