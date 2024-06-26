import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permissions/presentation/providers/providers.dart';
class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permisos'),
      ),
      body: const _PermissionsView(),
    );
  }
}

class _PermissionsView extends ConsumerWidget {
  const _PermissionsView();
  
  @override
  Widget build(BuildContext context, ref) {

    final permissions = ref.watch(permissionProvider);

    return ListView(
      children: [
        CheckboxListTile(
          value: permissions.cameraGranted, 
          title: const Text('Cámara'),
          subtitle: Text('${permissions.camera}'),
          onChanged: (_){
            ref.read(permissionProvider.notifier).requestCameraAccess();
          }
          ),

          CheckboxListTile(
          value: permissions.photolibraryGranted, 
          title: const Text('galeria de fotos'),
          subtitle: Text('${permissions.photolibrary}'),
          onChanged: (_){
            ref.read(permissionProvider.notifier).requestPhotoLibraryAccess();
          }
          ),

          CheckboxListTile(
          value: permissions.sensorsGranted, 
          title: const Text('Sensores'),
          subtitle: Text('${permissions.sensors}'),
          onChanged: (_){
            ref.read(permissionProvider.notifier).requestSensorsAccess();
          }
          ),

          CheckboxListTile(
          value: permissions.sensorsAlwaysGranted, 
          title: const Text('Sensores siempre activos'),
          subtitle: Text('${permissions.sensorsAlways}'),
          onChanged: (_){
            ref.read(permissionProvider.notifier).requestSensorsAlwaysAccess();
          }
          ),

          CheckboxListTile(
          value: permissions.locationGranted, 
          title: const Text('Ubicacion'),
          subtitle: Text('${permissions.location}'),
          onChanged: (_){
            ref.read(permissionProvider.notifier).requestLocationAccess();
          }
          ),

          CheckboxListTile(
          value: permissions.locationAlwaysGranted, 
          title: const Text('Ubicacion siempre activa'),
          subtitle: Text('${permissions.locationAlways}'),
          onChanged: (_){
            ref.read(permissionProvider.notifier).requestLocationAlwaysAccess();
          }
          ),

          CheckboxListTile(
          value: permissions.locationWhenInUseGranted, 
          title: const Text('Ubicacion mientras se usa'),
          subtitle: Text('${permissions.locationWhenInUse}'),
          onChanged: (_){
            ref.read(permissionProvider.notifier).requestLocationWhenInUseAccess();
          }
          ),
      ],
    );
  }
}