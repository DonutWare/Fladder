#!/bin/sh
set -e

CONFIG="/usr/share/nginx/html/assets/config/config.json"
NGINX_CONF="/etc/nginx/conf.d/default.conf"

# Strip trailing slashes from SEERR_BASE_URL so proxy_pass doesn't emit a double slash.
SEERR_BASE_URL=$(echo "$SEERR_BASE_URL" | sed 's|/*$||')

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
  "baseUrl": "$BASE_URL",
  "seerrBaseUrl": "$SEERR_BASE_URL",
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
GEO_BLOCK=""
if [ -n "$SEERR_PROXY_PATH" ]; then
  # CR/LF are forbidden in HTTP header values (RFC 9110 §5.5) — reject rather than escape.
  if printf '%s' "$SEERR_HEADER" | jq -e '[.[] | test("[\r\n]")] | any' > /dev/null; then
    echo "Error: SEERR_HEADER values must not contain newline or carriage return (invalid HTTP header values)" >&2
    exit 1
  fi
  # nginx has no native escape for literal '$' in quoted strings; define a namespaced
  # variable holding "$" at http level and substitute '$' -> '${seerr_literal_dollar}'
  # in values. Namespace prefix avoids collision with user-mounted nginx configs.
  # tojson handles " and \ escaping (nginx shares those conventions with JSON).
  HEADER_DIRECTIVES=$(printf '%s' "$SEERR_HEADER" | jq -r '
    to_entries[] |
    "        proxy_set_header " + .key + " " + (.value | gsub("\\$"; "${seerr_literal_dollar}") | tojson) + ";"
  ')

  GEO_BLOCK='geo $seerr_literal_dollar {
    default "$";
}
'
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
${GEO_BLOCK}server {
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
${GEO_BLOCK}server {
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

