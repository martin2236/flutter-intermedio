import 'package:flutter/material.dart';

class GiroscopioScreen extends StatelessWidget {
  const GiroscopioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('giroscopio screen'),
      ),
      body: Center(
        child: Text('hola'),
      ),
    );
  }
}