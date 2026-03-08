FROM nginx:alpine

EXPOSE 80

ENV BASE_URL=""
ENV SEERR_BASE_URL=""
ENV SEERR_HEADER="null"

COPY build/web /usr/share/nginx/html
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN mkdir -p /usr/share/nginx/html/assets/config && \
    chmod +x /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]
