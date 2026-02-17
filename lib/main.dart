import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatting App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController one = TextEditingController();

  // User-defined TextField dimensions
  static const double textFieldWidth = 300.0;  // Customize width here
  static const double textFieldHeight = 60.0;  // Customize height here
  static const int maxLines = 1;  // Number of lines
  static const int maxCharacters = 100;  // Maximum character length
  late String receivedMessage = "";
  late String message = "no message yet";
  void _sendMessage() {
    if (one.text.isEmpty) return;  // Guard clause
    setState(() {
      message = one.text;
      receivedMessage += (receivedMessage.isEmpty ? '' : '\n') + message;
    });
    log('Message sent: $message');
    one.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            
          ),
          child: Text(widget.title),
        ), 
      ),


      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Left half - Text
            Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Enter message:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration:BoxDecoration(
                        border :Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: Text(
                        '-----Message History-----\n\n${receivedMessage.isEmpty? 'No messages' : receivedMessage}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Right half - TextField
            Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: textFieldWidth,  // User-defined width
                      height: textFieldHeight,  // User-defined height
                      child: TextField(
                        controller: one,
                        maxLength: maxCharacters,
                        maxLines: maxLines,  // Control vertical size
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Type here',
                          counterText: '',  // Hide character counter to save space
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _sendMessage,
                      child: const Text('Send'),
                      ),
                      Text("Received message : $message"),
                  ],
                ),
                
              ),
            ),
          ],
        ),
      ),
      //floatingActionButton: FloatingActionButton(
        //onPressed: _incrementCounter,
        //tooltip: 'Increment',
        //child: const Icon(Icons.add),
      //),
    );
  }
  @override
  void dispose() {
    one.dispose();
    super.dispose();
  }
}
