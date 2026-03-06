FROM nginx:alpine

RUN apk add --no-cache jq

EXPOSE 80

ENV BASE_URL=""
ENV SEERR_URL=""
ENV HIDE_PASSWORD_LOGIN=""
ENV SEERR_CUSTOM_HEADERS=""
ENV PORT=80

COPY build/web /usr/share/nginx/html
COPY docker/docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]
