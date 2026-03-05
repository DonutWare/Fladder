FROM nginx:alpine

EXPOSE 80

ENV BASE_URL=""
ENV SEERR_URL=""
ENV HIDE_PASSWORD_LOGIN=""

COPY build/web /usr/share/nginx/html

RUN echo '{"baseUrl": "${BASE_URL}", "seerrUrl": "${SEERR_URL}", "hidePasswordLogin": __HIDE_PW__}' > /usr/share/nginx/html/assets/config/config.json

CMD /bin/sh -c '\
  HIDE_PW_VAL=$([ "$HIDE_PASSWORD_LOGIN" = "true" ] && echo true || echo null) && \
  sed -i "s|__HIDE_PW__|${HIDE_PW_VAL}|g" /usr/share/nginx/html/assets/config/config.json && \
  sed -i "s|\${BASE_URL}|${BASE_URL}|g" /usr/share/nginx/html/assets/config/config.json && \
  sed -i "s|\${SEERR_URL}|${SEERR_URL}|g" /usr/share/nginx/html/assets/config/config.json && \
  nginx -g "daemon off;"'
