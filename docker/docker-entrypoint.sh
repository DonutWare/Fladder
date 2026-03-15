#!/bin/sh
set -e

CONFIG="/usr/share/nginx/html/assets/config/config.json"
NGINX_CONF="/etc/nginx/conf.d/default.conf"

# --- Build config.json ---

# Determine seerrProxyPath: set when both SEERR_BASE_URL and SEERR_CUSTOM_HEADERS are provided
if [ -n "$SEERR_BASE_URL" ] && [ -n "$SEERR_CUSTOM_HEADERS" ]; then
  SEERR_PROXY_PATH="/seerr-proxy"
else
  SEERR_PROXY_PATH=""
fi

SEERR_PROXY_JSON=$([ -n "$SEERR_PROXY_PATH" ] && echo "\"$SEERR_PROXY_PATH\"" || echo null)

cat > "$CONFIG" <<EOF
{
  "baseUrl": $([ -n "$BASE_URL" ] && echo "\"$BASE_URL\"" || echo null),
  "seerrBaseUrl": $([ -n "$SEERR_BASE_URL" ] && echo "\"$SEERR_BASE_URL\"" || echo null),
  "seerrProxyPath": $SEERR_PROXY_JSON
}
EOF

# --- Build nginx config ---

PROXY_BLOCK=""
if [ -n "$SEERR_BASE_URL" ] && [ -n "$SEERR_CUSTOM_HEADERS" ]; then
  # Build proxy_set_header directives from JSON object
  HEADER_DIRECTIVES=$(echo "$SEERR_CUSTOM_HEADERS" | jq -r 'to_entries[] | "        proxy_set_header \(.key) \"\(.value)\";"')

  PROXY_BLOCK="
    location ${SEERR_PROXY_PATH}/ {
        proxy_pass ${SEERR_BASE_URL}/;
        proxy_set_header Host \$proxy_host;
        proxy_ssl_server_name on;
${HEADER_DIRECTIVES}
    }"
fi

cat > "$NGINX_CONF" <<EOF
server {
    listen ${PORT};
    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files \$uri \$uri/ /index.html;
    }
${PROXY_BLOCK}
}
EOF

# --- Start nginx ---

exec nginx -g "daemon off;"
