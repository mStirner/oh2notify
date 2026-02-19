# oh2notify
Desktop notifications for WebSocket events — listens to a WebSocket endpoint and displays incoming messages as native desktop notifications:
![demo](./docs/demo.png)

## Requirements

- Linux with `libnotify` / a notification daemon (e.g. GNOME, KDE, dunst)
- Node.js + npm (only for building)


## Build

```bash
npm install
npm run build
```

The binary will be at `./build/oh-notify`.


## Install

```bash
chmod +x install.sh
./install.sh [ws-url]
```

**Examples:**
```bash
./install.sh # uses default URL
./install.sh ws://open-haus.lan/api/system/notifications
```

The install script will:
- Copy the binary to `~/.local/bin/oh-notify`
- Create a systemd user service at `~/.config/systemd/user/oh-notify.service`
- Enable and start the service automatically


## Usage

```bash
oh-notify ws://open-haus.lan/api/system/notifications
```


## Service Management

```bash
systemctl --user status oh-notify      # check status
systemctl --user stop oh-notify        # stop
systemctl --user restart oh-notify     # restart
journalctl --user -u oh-notify -f      # live logs
```


## Expected Message Format

```json
{
  "title": "Title",
  "message": "Hello World",
  "type": "error"
}
```


## Uninstall

```bash
systemctl --user stop oh-notify
systemctl --user disable oh-notify
rm ~/.local/bin/oh-notify
rm ~/.config/systemd/user/oh-notify.service
systemctl --user daemon-reload
```