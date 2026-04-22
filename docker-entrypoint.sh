#!/bin/sh
set -e

# Generate config.json from environment variables
cat > /usr/share/nginx/html/assets/config/config.json <<EOF
{
  "baseUrl": "$BASE_URL",
  "seerrBaseUrl": "$SEERR_BASE_URL"
}
EOF

# Normalize FLADDER_WEBPATH (e.g. /fladder/)
WEBPATH=$(echo "${FLADDER_WEBPATH:-/}" | sed 's|^/*|/|; s|/*$|/|')

# Update base href in index.html (always at root of build/web)
if [ -f "/usr/share/nginx/html/index.html" ]; then
  sed -i "s|<base href=\"[^\"]*\">|<base href=\"$WEBPATH\">|g" /usr/share/nginx/html/index.html
fi

# Determine port (standard Nginx uses 80, rootless typically 8080)
if [ "$(id -u)" = "0" ]; then
    PORT=80
else
    PORT=8080
fi

if [ "$WEBPATH" = "/" ]; then
    echo "Configuring Fladder at root path"
    cat > /etc/nginx/conf.d/default.conf <<EOF
server {
    listen $PORT;
    listen [::]:$PORT;
    server_name localhost;

    location / {
        root /usr/share/nginx/html;
        index index.html;
        try_files \$uri \$uri/ /index.html;
    }
}
EOF
else
    echo "Configuring Fladder on subpath: $WEBPATH"
    WEBPATH_NO_SLASH=$(echo "$WEBPATH" | sed 's|/*$||')
    
    cat > /etc/nginx/conf.d/default.conf <<EOF
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

    # Fallback for root or other paths
    location / {
        return 404;
    }
}
EOF
fi

exec nginx -g "daemon off;"

