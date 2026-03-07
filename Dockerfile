FROM nginx:alpine

EXPOSE 80

ENV BASE_URL=""
ENV BASE_URL_SEERR=""

COPY build/web /usr/share/nginx/html

RUN echo '{"baseUrl": "${BASE_URL}", "baseUrlSeerr": "${BASE_URL_SEERR}"}' > /usr/share/nginx/html/assets/config/config.json

CMD /bin/sh -c 'sed -i "s|\${BASE_URL}|${BASE_URL}|g" /usr/share/nginx/html/assets/config/config.json && sed -i "s|\${BASE_URL_SEERR}|${BASE_URL_SEERR}|g" /usr/share/nginx/html/assets/config/config.json && nginx -g "daemon off;"'
