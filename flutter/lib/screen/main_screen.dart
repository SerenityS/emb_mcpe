import 'package:emb_motion/screen/sensor_test_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("EMB4 MCPE Motion Control")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SensorTestScreen(),
        ],
      ),
    );
  }
}
