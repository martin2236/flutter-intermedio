import 'package:flutter/material.dart';

class AcelerometroScreen extends StatelessWidget {
  const AcelerometroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('acelerometro'),
      ),
      body: Center(
        child: Text('hola'),
      ),
    );
  }
}