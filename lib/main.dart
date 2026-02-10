import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// STEP 1: Start the app
void main() {
  runApp(const MyApp());
}

// STEP 2: Create the main app widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple WebSocket Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WebSocketDemo(),
    );
  }
}

// STEP 3: Create the WebSocket demo page
class WebSocketDemo extends StatefulWidget {
  const WebSocketDemo({super.key});

  @override
  State<WebSocketDemo> createState() => _WebSocketDemoState();
}

class _WebSocketDemoState extends State<WebSocketDemo> {
  // Variables we need:
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = []; // Store all messages
  late WebSocketChannel _channel; // WebSocket connection

  @override
  void initState() {
    super.initState();
    _connectToWebSocket();
  }

  // STEP 4: Connect to WebSocket server
  void _connectToWebSocket() {
    // Using a free public echo server for testing
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://echo.websocket.events'),
    );

    // STEP 5: Listen for messages from server
    _channel.stream.listen((message) {
      setState(() {
        _messages.add('Received: $message');
      });
    });
  }

  // STEP 6: Send message to server
  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      String message = _messageController.text;
      _channel.sink.add(message); // Send to server

      setState(() {
        _messages.add('Sent: $message');
      });

      _messageController.clear(); // Clear input field
    }
  }

  @override
  void dispose() {
    _channel.sink.close(); // Close connection when done
    _messageController.dispose();
    super.dispose();
  }

  // STEP 7: Build the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WebSocket Demo'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Info Card
            Card(
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'This app demonstrates real-time communication using WebSocket.\n'
                  'Type a message and it will be sent to the server, which echoes it back!',
                  style: TextStyle(color: Colors.blue[900]),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Messages Display Area
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _messages.isEmpty
                    ? const Center(
                        child: Text(
                          'No messages yet. Send one below!',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          bool isSent = _messages[index].startsWith('Sent:');
                          return Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isSent
                                  ? Colors.blue[100]
                                  : Colors.green[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _messages[index],
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        },
                      ),
              ),
            ),
            const SizedBox(height: 16),

            // Input Area
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      labelText: 'Enter message',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _sendMessage,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
