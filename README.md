# WebSocket Client-Client Chat App

A Flutter application for real-time client-to-client communication using WebSocket protocol.

## Features

- ✅ **Real-time messaging** between multiple clients
- ✅ **Custom username** for each client
- ✅ **Connection management** (connect/disconnect)
- ✅ **Configurable server URL**
- ✅ **Connection status indicator**
- ✅ **Chat-style UI** with message bubbles
- ✅ **Timestamp** for each message
- ✅ **System notifications** (join/leave messages)
- ✅ **JSON-based message protocol**

## How It Works

1. **Connect**: Enter a username and WebSocket server URL, then click "Connect"
2. **Chat**: Type messages and send them to all connected clients
3. **Receive**: See messages from other clients in real-time
4. **Disconnect**: Click "Disconnect" when done

## Testing with Echo Server

By default, the app uses a public echo server (`wss://echo.websocket.events`) for testing. This server simply echoes back any message you send.

## Running the App

```bash
# Get dependencies
flutter pub get

# Run the app
flutter run
```

## Using with Multiple Clients

To test client-client communication:

1. Run the app on multiple devices/emulators
2. Connect all instances to the same WebSocket server
3. Send messages from any client to see them appear on all connected clients

## WebSocket Server Setup (Optional)

For true client-client communication, you'll need a WebSocket server that broadcasts messages to all connected clients.

### Simple Node.js WebSocket Server

Create a file `server.js`:

```javascript
const WebSocket = require('ws');

const server = new WebSocket.Server({ port: 8080 });

server.on('connection', (ws) => {
  console.log('Client connected');

  ws.on('message', (message) => {
    console.log('Received:', message.toString());
    
    // Broadcast to all connected clients
    server.clients.forEach((client) => {
      if (client.readyState === WebSocket.OPEN) {
        client.send(message.toString());
      }
    });
  });

  ws.on('close', () => {
    console.log('Client disconnected');
  });
});

console.log('WebSocket server running on ws://localhost:8080');
```

Run the server:
```bash
npm install ws
node server.js
```

Then connect your Flutter app to `ws://localhost:8080` (or your server's IP address).

### Python WebSocket Server

Using `websockets` library:

```python
import asyncio
import websockets

clients = set()

async def handler(websocket):
    clients.add(websocket)
    try:
        async for message in websocket:
            # Broadcast to all clients
            await asyncio.gather(
                *[client.send(message) for client in clients],
                return_exceptions=True
            )
    finally:
        clients.remove(websocket)

async def main():
    async with websockets.serve(handler, "localhost", 8080):
        print("WebSocket server running on ws://localhost:8080")
        await asyncio.Future()  # run forever

asyncio.run(main())
```

Run the server:
```bash
pip install websockets
python server.py
```

## Message Format

Messages are sent as JSON:
```json
{
  "sender": "username",
  "message": "Hello, World!",
  "timestamp": "2026-02-10T10:30:00.000Z"
}
```

## Dependencies

- `flutter`: SDK
- `web_socket_channel`: ^2.4.5

## Troubleshooting

- **Cannot connect**: Make sure your WebSocket server is running and the URL is correct
- **Android network issues**: Add internet permission in `android/app/src/main/AndroidManifest.xml`:
  ```xml
  <uses-permission android:name="android.permission.INTERNET" />
  ```
- **iOS network issues**: Ensure App Transport Security is configured for non-HTTPS connections if needed

## License

This project is open source and available for learning purposes.
