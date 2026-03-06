FROM nginx:alpine

RUN apk add --no-cache jq

EXPOSE 80

ENV BASE_URL=""
ENV SEERR_URL=""
ENV HIDE_PASSWORD_LOGIN=""
ENV SEERR_CUSTOM_HEADERS=""

COPY build/web /usr/share/nginx/html
COPY docker/docker-entrypoint.sh /docker-entrypoint.sh
COPY docker/nginx.conf.template /docker-nginx.conf.template

RUN chmod +x /docker-entrypoint.sh && \
    sed -i 's|__PORT__|80|g' /docker-nginx.conf.template

CMD ["/docker-entrypoint.sh"]
