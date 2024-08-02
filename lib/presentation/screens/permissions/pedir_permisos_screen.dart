import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permissions/presentation/providers/providers.dart';

class PedirPermisosScreen extends ConsumerWidget {
  const PedirPermisosScreen({super.key});

  @override
  Widget build(BuildContext context,ref) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permisos requeridos'),
      ),
      body: Center(
        child: FilledButton(
          onPressed: (){
              ref.read(permissionProvider.notifier).requestLocationAccess();
          },
          child: const Text('Localizacion necesaria')
        ),
      ),
    );
  }
}