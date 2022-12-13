import 'package:emb_motion/provider/compass_provider.dart';
import 'package:emb_motion/provider/linear_provider.dart';
import 'package:emb_motion/provider/accel_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  late AccelProvider _accelProvider;
  late CompassProvider _compassProvider;
  late LinearProvider _linearProvider;

  @override
  Widget build(BuildContext context) {
    _accelProvider = Provider.of<AccelProvider>(context);
    _compassProvider = Provider.of<CompassProvider>(context);
    _linearProvider = Provider.of<LinearProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("EMB4 MCPE Motion Control")),
      body: Builder(
        builder: ((context) {
          return Column(
            children: [
              const Text(
                "Acceleration Sensor Test",
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.only(top: 16.0)),
              Consumer<AccelProvider>(builder: (context, provider, child) {
                return Text(
                  "X = ${_accelProvider.accelData.x.toStringAsFixed(1)}",
                  textAlign: TextAlign.center,
                );
              }),
              const Padding(padding: EdgeInsets.only(top: 16.0)),
              Consumer<AccelProvider>(builder: (context, provider, child) {
                return Text(
                  "Y = ${_accelProvider.accelData.y.toStringAsFixed(1)}",
                  textAlign: TextAlign.center,
                );
              }),
              const Padding(padding: EdgeInsets.only(top: 16.0)),
              Consumer<AccelProvider>(builder: (context, provider, child) {
                return Text(
                  "Z = ${_accelProvider.accelData.z.toStringAsFixed(1)}",
                  textAlign: TextAlign.center,
                );
              }),
              const Padding(padding: EdgeInsets.only(top: 16.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    color: Colors.green,
                    onPressed: () => _accelProvider.startAccel(),
                    child: const Text("Start"),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  MaterialButton(
                    color: Colors.red,
                    onPressed: () => _accelProvider.stopAccel(),
                    child: const Text("Stop"),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
              const Text(
                "Linear Acceleration Sensor Test",
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.only(top: 16.0)),
              Consumer<LinearProvider>(builder: (context, provider, child) {
                return Text(
                  "X = ${_linearProvider.sensorData.x.toStringAsFixed(1)}",
                  textAlign: TextAlign.center,
                );
              }),
              const Padding(padding: EdgeInsets.only(top: 16.0)),
              Consumer<LinearProvider>(builder: (context, provider, child) {
                return Text(
                  "Y = ${_linearProvider.sensorData.y.toStringAsFixed(1)}",
                  textAlign: TextAlign.center,
                );
              }),
              const Padding(padding: EdgeInsets.only(top: 16.0)),
              Consumer<LinearProvider>(builder: (context, provider, child) {
                return Text(
                  "Z = ${_linearProvider.sensorData.z.toStringAsFixed(1)}",
                  textAlign: TextAlign.center,
                );
              }),
              const Padding(padding: EdgeInsets.only(top: 16.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    color: Colors.green,
                    onPressed: () => _linearProvider.startLinear(),
                    child: const Text("Start"),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  MaterialButton(
                    color: Colors.red,
                    onPressed: () => _linearProvider.stopLinear(),
                    child: const Text("Stop"),
                  ),
                ],
              ),
              const Text(
                "Compass Sensor Test",
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.only(top: 16.0)),
              Consumer<CompassProvider>(builder: (context, provider, child) {
                return Text(
                  "angle = ${_compassProvider.angle}",
                  textAlign: TextAlign.center,
                );
              }),
              const Padding(padding: EdgeInsets.only(top: 16.0)),
              Consumer<CompassProvider>(builder: (context, provider, child) {
                return Text(
                  "position = ${_compassProvider.position}",
                  textAlign: TextAlign.center,
                );
              }),
              const Padding(padding: EdgeInsets.only(top: 16.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    color: Colors.green,
                    onPressed: () => _compassProvider.startCompass(),
                    child: const Text("Start"),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  MaterialButton(
                    color: Colors.red,
                    onPressed: () => _compassProvider.stopCompass(),
                    child: const Text("Stop"),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
