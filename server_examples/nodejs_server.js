// Simple WebSocket Server for Client-Client Chat
// Install: npm install ws
// Run: node nodejs_server.js

const WebSocket = require('ws');

const PORT = 8080;
const server = new WebSocket.Server({ port: PORT });

const clients = new Set();

server.on('connection', (ws) => {
  console.log(`[${new Date().toLocaleTimeString()}] New client connected. Total clients: ${clients.size + 1}`);
  clients.add(ws);

  ws.on('message', (message) => {
    const messageStr = message.toString();
    console.log(`[${new Date().toLocaleTimeString()}] Received: ${messageStr}`);
    
    // Broadcast to all connected clients
    let successCount = 0;
    clients.forEach((client) => {
      if (client.readyState === WebSocket.OPEN) {
        try {
          client.send(messageStr);
          successCount++;
        } catch (error) {
          console.error('Error sending to client:', error);
        }
      }
    });
    
    console.log(`[${new Date().toLocaleTimeString()}] Broadcasted to ${successCount} clients`);
  });

  ws.on('close', () => {
    clients.delete(ws);
    console.log(`[${new Date().toLocaleTimeString()}] Client disconnected. Total clients: ${clients.size}`);
  });

  ws.on('error', (error) => {
    console.error(`[${new Date().toLocaleTimeString()}] WebSocket error:`, error);
    clients.delete(ws);
  });
});

server.on('error', (error) => {
  console.error('Server error:', error);
});

console.log(`════════════════════════════════════════════════`);
console.log(`  WebSocket Chat Server`);
console.log(`════════════════════════════════════════════════`);
console.log(`  Server running on: ws://localhost:${PORT}`);
console.log(`  Network address: ws://<your-ip>:${PORT}`);
console.log(`════════════════════════════════════════════════`);
console.log(`  Waiting for connections...`);
console.log(`════════════════════════════════════════════════\n`);
