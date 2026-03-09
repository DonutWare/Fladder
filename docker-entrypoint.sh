#!/bin/sh
set -e

# Generate config.json from environment variables
cat > /usr/share/nginx/html/assets/config/config.json <<EOF
{
  "baseUrl": "$BASE_URL",
  "seerrBaseUrl": "$SEERR_BASE_URL",
  "seerrHeader": $SEERR_HEADER
}
EOF

exec nginx -g "daemon off;"
