#!/bin/sh
# Gera o index.html final a cada start do container, usando a variável SITE_URL.
# Ex.: SITE_URL=https://engrenameubairro.com.br
set -e
SRC=/usr/share/nginx/index.template.html
DST=/usr/share/nginx/html/index.html
FALLBACK="https://directus.leanttro.com/assets/8b4ac80a-f97f-4edf-b37d-01bc5f187ba3?width=1200\&height=630\&fit=contain\&format=png"

SITE_URL="${SITE_URL%/}"
if [ -n "$SITE_URL" ]; then
  OG="$SITE_URL/og-image.jpg"
  sed -e "s|__OG_IMAGE__|$OG|g" -e "s|__SITE_URL__|$SITE_URL/|g" "$SRC" > "$DST"
  echo "[engrena] SITE_URL=$SITE_URL -> og:image=$OG"
else
  sed -e "s|__OG_IMAGE__|$FALLBACK|g" -e '/__SITE_URL__/d' "$SRC" > "$DST"
  echo "[engrena] SITE_URL não definida: usando logo do Directus como og:image"
fi
