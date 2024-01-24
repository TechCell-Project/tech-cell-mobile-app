import 'dart:async';

import 'package:flutter/material.dart';

class NotiScreen extends StatefulWidget {
  const NotiScreen({super.key});

  @override
  State<NotiScreen> createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
  final StreamController<int> _controller = StreamController<int>();

  // Initial value
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StreamBuilder Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // StreamBuilder widget
            StreamBuilder<int>(
              // Pass the stream
              stream: _controller.stream,
              // Initial data or null
              initialData: _counter,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                // Check if data is available
                if (snapshot.hasData) {
                  return Text(
                    'Counter: ${snapshot.data}',
                    style: TextStyle(fontSize: 20),
                  );
                } else {
                  return Text('Waiting for data...');
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Increment the counter and add it to the stream
          _counter++;
          _controller.add(_counter);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    // Close the stream when the widget is disposed
    _controller.close();
    super.dispose();
  }
}
