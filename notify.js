const WebSocket = require('ws');
const notifier = require('node-notifier');

const url = process.argv[2];

if (!url) {
  console.error('Usage: ws-notify <ws-url>');
  process.exit(1);
}

const ws = new WebSocket(url);

ws.on('message', (data) => {
  const { title, message } = JSON.parse(data);
  notifier.notify({ title: `OpenHaus - ${title}`, message });
});

ws.on('open', () => { console.log('Connected to:', ws.url)});
ws.on('error', (err) => console.error('WS Error:', err.message));
ws.on('close', () => console.log('Connection closed'));
