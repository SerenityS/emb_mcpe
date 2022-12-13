import 'package:emb_motion/provider/socket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogScreen extends StatelessWidget {
  LogScreen({super.key});

  late SocketProvider _socketProvider;

  @override
  Widget build(BuildContext context) {
    _socketProvider = Provider.of<SocketProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Consumer<SocketProvider>(builder: (context, provider, child) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: _socketProvider.logs.length,
            itemBuilder: ((context, index) {
              return Text(_socketProvider.logs[index]);
            }),
          );
        }),
      ),
    );
  }
}
