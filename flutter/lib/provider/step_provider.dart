import 'dart:async';
import 'dart:math';

import 'package:emb_motion/model/sensor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sensors/flutter_sensors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepProvider extends ChangeNotifier {
  Sensor accelData = Sensor(0.0, 0.0, 0.0);
  StreamSubscription? _accelSubscription;

  double _exactDistance = 0.0;
  double _previousDistance = 0.0;

  late SharedPreferences pref;

  Future<void> startStep() async {
    if (_accelSubscription != null) return;

    final stream = await SensorManager().sensorUpdates(
      sensorId: Sensors.ACCELEROMETER,
      interval: Sensors.SENSOR_DELAY_UI,
    );
    _accelSubscription = stream.listen(
      (sensorEvent) {
        accelData = Sensor(sensorEvent.data[0], sensorEvent.data[1], sensorEvent.data[2]);
        _exactDistance = calculateMagnitude(accelData.x, accelData.y, accelData.z);
        if (_exactDistance > 6) {
          // TODO: Implement Socket emit
          debugPrint("Step Detected.");
        }
        notifyListeners();
      },
    );
  }

  void stopStep() {
    if (_accelSubscription == null) return;
    _accelSubscription?.cancel();
    _accelSubscription = null;
  }

  double calculateMagnitude(double x, double y, double z) {
    double distance = sqrt(x * x + y * y + z * z);
    getPreviousValue();
    double mode = distance - _previousDistance;
    setprefData(distance);
    return mode;
  }

  void setprefData(double predistance) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble("previousDistance", predistance);
  }

  void getPreviousValue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _previousDistance = pref.getDouble("previousDistance") ?? 0;
  }
}
