import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permissions/presentation/providers/sensors/magnetometro_provider.dart';

class MagnetometroScreen extends ConsumerWidget {
  const MagnetometroScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final magnetometro$ = ref.watch(magnetometroProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('magnetometro screen'),
      ),
      body: Center(
        child: magnetometro$.when(
       data: (value) => Text(
            value.toString(),
            style: const TextStyle(fontSize: 30),
          ), 
          error: (error,stackTrace) => Text('$error'), 
          loading: () => const CircularProgressIndicator()
        ),
      ),
    );
  }
}