FROM nginx:alpine

RUN apk add --no-cache jq

EXPOSE 80

ENV BASE_URL=""
ENV SEERR_BASE_URL=""
ENV SEERR_HEADER="null"
ENV PORT=80

COPY build/web /usr/share/nginx/html
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN mkdir -p /usr/share/nginx/html/assets/config && \
    chmod +x /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]
