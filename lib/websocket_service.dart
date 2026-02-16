import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';class WebSocketService {
  late WebSocketChannel channel;
// Initialize WebSocket connection
  void connect(String url) {
    channel = IOWebSocketChannel.connect(url);
  }
  // Send message to the WebSocket server
  void sendMessage(String message) {
    channel.sink.add(message);
  }
  // Listen for incoming messages
  Stream get messages => channel.stream;
  // Close the connection
  void disconnect() {
    channel.sink.close();
  }
}