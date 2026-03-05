FROM nginx:alpine

EXPOSE 80

ENV BASE_URL=""
ENV SEERR_URL=""

COPY build/web /usr/share/nginx/html

RUN echo '{"baseUrl": "${BASE_URL}", "seerrUrl": "${SEERR_URL}"}' > /usr/share/nginx/html/assets/config/config.json

CMD /bin/sh -c 'sed -i "s|\${BASE_URL}|${BASE_URL}|g" /usr/share/nginx/html/assets/config/config.json && sed -i "s|\${SEERR_URL}|${SEERR_URL}|g" /usr/share/nginx/html/assets/config/config.json && nginx -g "daemon off;"'
