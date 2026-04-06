#!/bin/sh
set -e

# Generate config.json from environment variables
cat > /usr/share/nginx/html/assets/config/config.json <<EOF
{
  "baseUrl": "$BASE_URL",
  "seerrBaseUrl": "$SEERR_BASE_URL"
}
EOF

if [ -n "$FLADDER_WEBPATH" ]; then
  sed -i "s|<base href=\"[^\"]*\">|<base href=\"$FLADDER_WEBPATH\">|g" /usr/share/nginx/html/index.html
fi

exec nginx -g "daemon off;"
