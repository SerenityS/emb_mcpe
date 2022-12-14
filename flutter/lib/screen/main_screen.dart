import 'package:emb_motion/provider/bottom_navigation_provider.dart';
import 'package:emb_motion/screen/log_screen.dart';
import 'package:emb_motion/screen/sensor_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  late BottomNavigationProvider _bottomNavigationProvider;

  Widget _navigationBody() {
    switch (_bottomNavigationProvider.currentPage) {
      case 0:
        return SensorTestScreen();
      case 1:
        return LogScreen();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    _bottomNavigationProvider = Provider.of<BottomNavigationProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("EMB4 MCPE Motion Control")),
      body: _navigationBody(),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }

  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.sensors_outlined), label: "Sensors"),
        BottomNavigationBarItem(icon: Icon(Icons.description_outlined), label: "Log"),
      ],
      currentIndex: _bottomNavigationProvider.currentPage,
      selectedItemColor: Colors.teal,
      onTap: (index) {
        _bottomNavigationProvider.updateCurrentPage(index);
      },
    );
  }
}
