import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class CompassProvider extends ChangeNotifier {
  StreamSubscription? _compassSubscription;

  double angle = 0.0;
  double _prev = 0.0;
  String position = "same";

  Future<void> startCompass() async {
    if (_compassSubscription != null) return;

    final stream = FlutterCompass.events;
    _compassSubscription = stream!.listen(
      (sensorEvent) {
        final compassData = sensorEvent;
        double? direction = compassData.heading;
        angle = direction! * (math.pi / 180) * -1;

        // TODO: Implement Socket emit
        if ((_prev - angle).abs() > 0.05) {
          if (_prev < angle) {
            position = "left";
          } else {
            position = "right";
          }
        } else {
          position = "stay";
        }
        _prev = angle;
        notifyListeners();
      },
    );
  }

  void stopCompass() {
    if (_compassSubscription == null) return;
    _compassSubscription?.cancel();
    _compassSubscription = null;
  }
}
