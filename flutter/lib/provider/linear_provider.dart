import 'dart:async';

import 'package:emb_motion/model/sensor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sensors/flutter_sensors.dart';

class LinearProvider extends ChangeNotifier {
  Sensor sensorData = Sensor(0.0, 0.0, 0.0);
  StreamSubscription? _linearSubscription;

  Future<void> startLinear() async {
    if (_linearSubscription != null) return;

    final stream = await SensorManager().sensorUpdates(
      sensorId: Sensors.LINEAR_ACCELERATION,
      interval: Sensors.SENSOR_DELAY_UI,
    );
    _linearSubscription = stream.listen(
      (sensorEvent) {
        sensorData = Sensor(sensorEvent.data[0], sensorEvent.data[1], sensorEvent.data[2]);
        if (sensorData.x > 40) {
          // TODO: Implement Socket emit
          debugPrint("Swing Detected.");
        }
        notifyListeners();
      },
    );
  }

  void stopLinear() {
    if (_linearSubscription == null) return;
    _linearSubscription?.cancel();
    _linearSubscription = null;
  }
}
