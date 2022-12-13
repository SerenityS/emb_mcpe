import 'package:emb_motion/provider/bottom_navigation_provider.dart';
import 'package:emb_motion/provider/compass_provider.dart';
import 'package:emb_motion/provider/linear_provider.dart';
import 'package:emb_motion/provider/accel_provider.dart';
import 'package:emb_motion/provider/socket_provider.dart';
import 'package:emb_motion/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => BottomNavigationProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => AccelProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => CompassProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => LinearProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => SocketProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: MainScreen(),
      ),
    );
  }
}
