#!/bin/sh
set -e

CONFIG="/usr/share/nginx/html/assets/config/config.json"
NGINX_CONF="/etc/nginx/conf.d/default.conf"

# --- Build config.json ---

# Determine seerrProxyPath: set when both SEERR_BASE_URL and SEERR_HEADER are provided
if [ -n "$SEERR_BASE_URL" ] && [ -n "$SEERR_HEADER" ] && [ "$SEERR_HEADER" != "null" ]; then
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

# --- Normalize FLADDER_WEBPATH (e.g. /fladder/) ---
WEBPATH=$(echo "${FLADDER_WEBPATH:-/}" | sed 's|^/*|/|; s|/*$|/|')

# Update base href in index.html (always at root of build/web)
if [ -f "/usr/share/nginx/html/index.html" ]; then
  sed -i "s|<base href=\"[^\"]*\">|<base href=\"$WEBPATH\">|g" /usr/share/nginx/html/index.html
fi

# --- Determine port ---
# Honor $PORT from env if set; otherwise default by uid (0 => 80, else 8080).
PORT="${PORT:-$([ "$(id -u)" = "0" ] && echo 80 || echo 8080)}"

# --- Build Seerr proxy block ---
PROXY_BLOCK=""
if [ -n "$SEERR_PROXY_PATH" ]; then
  HEADER_DIRECTIVES=$(echo "$SEERR_HEADER" | jq -r 'to_entries[] | "        proxy_set_header \(.key) \"\(.value)\";"')

  PROXY_BLOCK="
    location ${SEERR_PROXY_PATH}/ {
        proxy_pass ${SEERR_BASE_URL}/;
        proxy_set_header Host \$proxy_host;
        proxy_ssl_server_name on;
${HEADER_DIRECTIVES}
    }"
fi

# --- Emit nginx config ---
if [ "$WEBPATH" = "/" ]; then
    echo "Configuring Fladder at root path"
    cat > "$NGINX_CONF" <<EOF
server {
    listen $PORT;
    listen [::]:$PORT;
    server_name localhost;

    location / {
        root /usr/share/nginx/html;
        index index.html;
        try_files \$uri \$uri/ /index.html;
    }
${PROXY_BLOCK}
}
EOF
else
    echo "Configuring Fladder on subpath: $WEBPATH"
    WEBPATH_NO_SLASH=$(echo "$WEBPATH" | sed 's|/*$||')

    cat > "$NGINX_CONF" <<EOF
server {
    listen $PORT;
    listen [::]:$PORT;
    server_name localhost;

    # Handle the subpath
    location $WEBPATH {
        alias /usr/share/nginx/html/;
        index index.html;
        try_files \$uri \$uri/ $WEBPATH/index.html;
    }

    # Redirect without trailing slash
    location = $WEBPATH_NO_SLASH {
        return 301 $WEBPATH;
    }
${PROXY_BLOCK}

    # Fallback for root or other paths
    location / {
        return 404;
    }
}
EOF
fi

# --- Start nginx ---

exec nginx -g "daemon off;"

