

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GiroscopioXYZ{
  final double x;
  final double y;
  final double z;

  GiroscopioXYZ(this.x, this.y, this.z);
}

final giroscopioProvider = StreamProvider<GiroscopioXYZ>((ref) {
  return SensorsPlatform.instance.accelerometerEventStream().map((event) {
    return GiroscopioXYZ(event.x, event.y, event.z);
  });
});