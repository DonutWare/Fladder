FROM nginx:alpine

EXPOSE 80

ENV BASE_URL=""
ENV SEERR_BASE_URL=""
ENV SEERR_HEADER="null"

COPY build/web /usr/share/nginx/html

RUN echo '{"baseUrl": "${BASE_URL}", "seerrBaseUrl": "${SEERR_BASE_URL}", "seerrHeader": ${SEERR_HEADER}}' > /usr/share/nginx/html/assets/config/config.json

CMD /bin/sh -c 'sed -i "s|\${BASE_URL}|${BASE_URL}|g" /usr/share/nginx/html/assets/config/config.json && sed -i "s|\${SEERR_BASE_URL}|${SEERR_BASE_URL}|g" /usr/share/nginx/html/assets/config/config.json && sed -i "s|\${SEERR_HEADER}|${SEERR_HEADER}|g" /usr/share/nginx/html/assets/config/config.json && nginx -g "daemon off;"'
