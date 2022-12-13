import 'dart:async';
import 'dart:math';

import 'package:emb_motion/constant.dart';
import 'package:emb_motion/model/sensor_model.dart';
import 'package:emb_motion/provider/socket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sensors/flutter_sensors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccelProvider extends ChangeNotifier {
  Sensor sensorData = Sensor(0.0, 0.0, 0.0);
  StreamSubscription? _accelSubscription;

  double _exactDistance = 0.0;
  double _previousDistance = 0.0;

  int _threshold = 0;
  bool _isDetected = false;

  late SharedPreferences pref;

  Future<void> startAccel() async {
    if (_accelSubscription != null) return;

    final stream = await SensorManager().sensorUpdates(
      sensorId: Sensors.ACCELEROMETER,
      interval: Sensors.SENSOR_DELAY_UI,
    );
    _accelSubscription = stream.listen(
      (sensorEvent) {
        sensorData = Sensor(sensorEvent.data[0], sensorEvent.data[1], sensorEvent.data[2]);
        _exactDistance = calculateMagnitude(sensorData.x, sensorData.y, sensorData.z);
        if (!_isDetected) {
          if (_exactDistance > 6) {
            SocketProvider.socket!.emit(
              'action',
              {
                'name': wsName,
                'action': 'Step',
              },
            );
            debugPrint("Step Detected.");
            _isDetected = true;
          }
        } else {
          _threshold++;
          if (_threshold == 5) {
            _isDetected = false;
            _threshold = 0;
          }
        }
        notifyListeners();
      },
    );
  }

  void stopAccel() {
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
