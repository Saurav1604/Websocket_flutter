#!/usr/bin/env python3
"""
Simple WebSocket Server for Client-Client Chat
Install: pip install websockets
Run: python python_server.py
"""

import asyncio
import websockets
from datetime import datetime

# Store connected clients
clients = set()

async def handler(websocket):
    """Handle incoming WebSocket connections"""
    # Register client
    clients.add(websocket)
    client_count = len(clients)
    print(f"[{datetime.now().strftime('%H:%M:%S')}] New client connected. Total clients: {client_count}")
    
    try:
        async for message in websocket:
            print(f"[{datetime.now().strftime('%H:%M:%S')}] Received: {message}")
            
            # Broadcast message to all connected clients
            if clients:
                # Send to all clients concurrently
                await asyncio.gather(
                    *[client.send(message) for client in clients if client.open],
                    return_exceptions=True
                )
                print(f"[{datetime.now().strftime('%H:%M:%S')}] Broadcasted to {len(clients)} clients")
    
    except websockets.exceptions.ConnectionClosed:
        pass
    
    finally:
        # Unregister client
        clients.remove(websocket)
        print(f"[{datetime.now().strftime('%H:%M:%S')}] Client disconnected. Total clients: {len(clients)}")

async def main():
    """Start WebSocket server"""
    port = 8080
    
    print("=" * 50)
    print("  WebSocket Chat Server")
    print("=" * 50)
    print(f"  Server running on: ws://localhost:{port}")
    print(f"  Network address: ws://<your-ip>:{port}")
    print("=" * 50)
    print("  Waiting for connections...")
    print("=" * 50)
    print()
    
    async with websockets.serve(handler, "0.0.0.0", port):
        await asyncio.Future()  # Run forever

if __name__ == "__main__":
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        print("\n\nServer stopped by user")
