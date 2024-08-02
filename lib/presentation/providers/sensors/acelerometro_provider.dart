

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AcelerometroXYZ{
  final double x;
  final double y;
  final double z;

  AcelerometroXYZ(this.x, this.y, this.z);

  @override
  String toString(){
      return'''
        x:$x,
        y:$y,
        z:$z
      ''';
  }
}

final acelerometroConGravedadProvider = StreamProvider.autoDispose<AcelerometroXYZ>((ref) {
  return SensorsPlatform.instance.accelerometerEventStream().map((event) {
    final x = double.parse(event.x.toStringAsFixed(2));
    final y = double.parse(event.y.toStringAsFixed(2));
    final z = double.parse(event.z.toStringAsFixed(2));
    return AcelerometroXYZ(x, y, z);
  });
});

final acelerometroProvider = StreamProvider.autoDispose<AcelerometroXYZ>((ref) {
  return SensorsPlatform.instance.userAccelerometerEventStream().map((event) {
    final x = double.parse(event.x.toStringAsFixed(2));
    final y = double.parse(event.y.toStringAsFixed(2));
    final z = double.parse(event.z.toStringAsFixed(2));
    return AcelerometroXYZ(x, y, z);
  });
});