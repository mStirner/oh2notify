#!/bin/bash
set -e

BINARY_SRC="./build/oh-notify"
BINARY_DEST="$HOME/.local/bin/oh-notify"
SERVICE_DEST="$HOME/.config/systemd/user/oh-notify.service"
WS_URL="${1:-ws://open-haus.lan/api/system/notifications}"

# Dirs erstellen
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.config/systemd/user"

# Binary kopieren
cp "$BINARY_SRC" "$BINARY_DEST"
chmod +x "$BINARY_DEST"

# Unit file schreiben
cat > "$SERVICE_DEST" <<EOF
[Unit]
Description=OpenHaus WebSocket Notifications
After=network.target

[Service]
ExecStart=$BINARY_DEST $WS_URL
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
EOF

# Systemd neu laden & aktivieren
systemctl --user daemon-reload
systemctl --user enable oh-notify
systemctl --user restart oh-notify

echo "✓ oh-notify installiert und gestartet"
echo "  URL: $WS_URL"
echo "  Logs: journalctl --user -u oh-notify -f"