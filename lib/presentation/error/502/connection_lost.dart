import 'package:flutter/material.dart';

class ConnectionLostScreen extends StatelessWidget {
  const ConnectionLostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Lost Connection!'),
      ),
    );
  }
}
