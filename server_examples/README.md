# WebSocket Server Examples

This directory contains simple WebSocket server implementations for testing the Flutter chat app.

## Node.js Server

### Prerequisites
- Node.js installed on your system

### Setup & Run
```bash
# Install dependencies
npm install ws

# Run the server
node nodejs_server.js
```

The server will start on `ws://localhost:8080`

## Python Server

### Prerequisites
- Python 3.7+ installed on your system

### Setup & Run
```bash
# Install dependencies
pip install websockets

# Run the server
python python_server.py
```

The server will start on `ws://localhost:8080`

## Connecting from Flutter App

1. Start one of the servers above
2. Open the Flutter app
3. Enter the server URL:
   - If testing on the same machine: `ws://localhost:8080`
   - If testing on different devices: `ws://<YOUR_IP>:8080`
4. Enter a username and click "Connect"

## Finding Your IP Address

### Windows
```cmd
ipconfig
```
Look for "IPv4 Address"

### macOS/Linux
```bash
ifconfig
# or
ip addr show
```

### Example
If your IP is `192.168.1.100`, use `ws://192.168.1.100:8080` in the Flutter app.

## Testing Multiple Clients

1. Start the server
2. Run the Flutter app on multiple devices/emulators
3. Connect all instances to the same server
4. Start chatting!

## Features

Both servers:
- ✅ Accept WebSocket connections
- ✅ Broadcast messages to all connected clients
- ✅ Handle connection/disconnection events
- ✅ Log activity to console
- ✅ Support multiple simultaneous clients

## Troubleshooting

**Port already in use:**
- Change the port number in the server file
- Make sure to update the port in your Flutter app connection URL

**Cannot connect from another device:**
- Ensure both devices are on the same network
- Check firewall settings
- Use your local IP address, not localhost

**Connection refused:**
- Make sure the server is running
- Verify the IP address and port are correct
- Check network connectivity
