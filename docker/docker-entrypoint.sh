#!/bin/sh
set -e

CONFIG="/usr/share/nginx/html/assets/config/config.json"
NGINX_CONF="/etc/nginx/conf.d/default.conf"
NGINX_TEMPLATE="/docker-nginx.conf.template"

# --- Build config.json ---

HIDE_PW_VAL=$([ "$HIDE_PASSWORD_LOGIN" = "true" ] && echo true || echo null)

# Determine seerrProxyPath: set when both SEERR_URL and SEERR_CUSTOM_HEADERS are provided
if [ -n "$SEERR_URL" ] && [ -n "$SEERR_CUSTOM_HEADERS" ]; then
  SEERR_PROXY_PATH="/seerr-proxy"
else
  SEERR_PROXY_PATH=""
fi

SEERR_PROXY_JSON=$([ -n "$SEERR_PROXY_PATH" ] && echo "\"$SEERR_PROXY_PATH\"" || echo null)

cat > "$CONFIG" <<EOF
{
  "baseUrl": $([ -n "$BASE_URL" ] && echo "\"$BASE_URL\"" || echo null),
  "seerrUrl": $([ -n "$SEERR_URL" ] && echo "\"$SEERR_URL\"" || echo null),
  "hidePasswordLogin": $HIDE_PW_VAL,
  "seerrProxyPath": $SEERR_PROXY_JSON
}
EOF

# --- Build nginx config ---

if [ -n "$SEERR_URL" ] && [ -n "$SEERR_CUSTOM_HEADERS" ]; then
  # Build proxy_set_header directives from JSON object
  HEADER_DIRECTIVES=$(echo "$SEERR_CUSTOM_HEADERS" | jq -r 'to_entries[] | "    proxy_set_header \(.key) \"\(.value)\";"')

  PROXY_BLOCK="location /seerr-proxy/ {
    proxy_pass ${SEERR_URL}/;
    proxy_set_header Host \$proxy_host;
    proxy_ssl_server_name on;
${HEADER_DIRECTIVES}
  }"
else
  PROXY_BLOCK=""
fi

sed "s|__SEERR_PROXY_BLOCK__|${PROXY_BLOCK}|g" "$NGINX_TEMPLATE" > "$NGINX_CONF"

# --- Start nginx ---

exec nginx -g "daemon off;"
