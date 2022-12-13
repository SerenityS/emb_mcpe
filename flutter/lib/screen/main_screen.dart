import 'package:emb_motion/provider/linear_provider.dart';
import 'package:emb_motion/provider/step_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  late LinearProvider _linearProvider;
  late StepProvider _stepProvider;

  @override
  Widget build(BuildContext context) {
    _linearProvider = Provider.of<LinearProvider>(context);
    _stepProvider = Provider.of<StepProvider>(context);

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
              Consumer<StepProvider>(builder: (context, provider, child) {
                return Text(
                  "X = ${_stepProvider.accelData.x.toStringAsFixed(1)}",
                  textAlign: TextAlign.center,
                );
              }),
              const Padding(padding: EdgeInsets.only(top: 16.0)),
              Consumer<StepProvider>(builder: (context, provider, child) {
                return Text(
                  "Y = ${_stepProvider.accelData.y.toStringAsFixed(1)}",
                  textAlign: TextAlign.center,
                );
              }),
              const Padding(padding: EdgeInsets.only(top: 16.0)),
              Consumer<StepProvider>(builder: (context, provider, child) {
                return Text(
                  "Z = ${_stepProvider.accelData.z.toStringAsFixed(1)}",
                  textAlign: TextAlign.center,
                );
              }),
              const Padding(padding: EdgeInsets.only(top: 16.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    color: Colors.green,
                    onPressed: () => _stepProvider.startStep(),
                    child: const Text("Start"),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  MaterialButton(
                    color: Colors.red,
                    onPressed: () => _stepProvider.stopStep(),
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
            ],
          );
        }),
      ),
    );
  }
}
