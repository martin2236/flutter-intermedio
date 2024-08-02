

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MagnetometroXYZ{
  final double x;
  final double y;
  final double z;

  MagnetometroXYZ(this.x, this.y, this.z);

  @override
  String toString(){
      return'''
        x:$x,
        y:$y,
        z:$z
      ''';
  }
}

final magnetometroProvider = StreamProvider.autoDispose<MagnetometroXYZ>((ref) {
  return SensorsPlatform.instance.magnetometerEventStream().map((event) {
    final x = double.parse(event.x.toStringAsFixed(2));
    final y = double.parse(event.y.toStringAsFixed(2));
    final z = double.parse(event.z.toStringAsFixed(2));
    return MagnetometroXYZ(x, y, z);
  });
});