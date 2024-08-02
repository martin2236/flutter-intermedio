

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GiroscopioXYZ{
  final double x;
  final double y;
  final double z;

  GiroscopioXYZ(this.x, this.y, this.z);

  @override
  String toString(){
      return'''
        x:$x,
        y:$y,
        z:$z
      ''';
  }
}

final giroscopioProvider = StreamProvider.autoDispose<GiroscopioXYZ>((ref) {
  return SensorsPlatform.instance.gyroscopeEventStream().map((event) {
    final x = double.parse(event.x.toStringAsFixed(2));
    final y = double.parse(event.y.toStringAsFixed(2));
    final z = double.parse(event.z.toStringAsFixed(2));
    return GiroscopioXYZ(x, y, z);
  });
});