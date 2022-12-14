import 'package:emb_motion/constant.dart';
import 'package:emb_motion/provider/socket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

class LogScreen extends StatelessWidget {
  LogScreen({super.key});

  late SocketProvider _socketProvider;

  @override
  Widget build(BuildContext context) {
    _socketProvider = Provider.of<SocketProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Consumer<SocketProvider>(builder: (context, provider, child) {
            return SingleChildScrollView(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _socketProvider.logs.length,
                itemBuilder: ((context, index) {
                  return Text(_socketProvider.logs[index]);
                }),
              ),
            );
          }),
          Align(
            alignment: Alignment.bottomRight,
            child: SpeedDial(
              speedDialChildren: [
                SpeedDialChild(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.settings_outlined),
                  onPressed: () async {
                    addressDialog(context);
                  },
                ),
                SpeedDialChild(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.redAccent,
                  child: const Icon(Icons.delete_forever_outlined),
                  onPressed: () {
                    _socketProvider.clearLogs();
                  },
                ),
                SpeedDialChild(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.lightBlueAccent,
                  child: const Icon(Icons.play_arrow_outlined),
                  onPressed: () {
                    _socketProvider.connect();
                  },
                ),
              ],
              child: const Icon(Icons.menu_outlined),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addressDialog(BuildContext context) async {
    final textController = TextEditingController();
    textController.text = wsUrl;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("WebSocket Address"),
            content: TextField(
              controller: textController,
            ),
            actions: [
              TextButton(
                child: const Text("Save"),
                onPressed: () {
                  wsUrl = textController.text;
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
