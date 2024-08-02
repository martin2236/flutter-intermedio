import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permissions/presentation/providers/providers.dart';

class AcelerometroScreen extends ConsumerWidget {
  const AcelerometroScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final acelerometroConGravedad$ = ref.watch(acelerometroConGravedadProvider);
    final acelerometroSinGravedad$ = ref.watch(acelerometroProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('acelerometro'),
      ),
      body: Center(
      child: acelerometroConGravedad$.when(
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