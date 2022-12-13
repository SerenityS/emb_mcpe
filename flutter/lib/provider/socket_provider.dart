import 'package:emb_motion/constant.dart';
import 'package:emb_motion/util/stream_socket.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketProvider extends ChangeNotifier {
  static IO.Socket? socket;
  final StreamSocket _streamSocket = StreamSocket();

  final List<dynamic> logs = [];

  SocketProvider({required name}) {
    socket = IO.io(wsUrl, IO.OptionBuilder().setTransports(['websocket']).build());

    socket!.onConnect(
      (_) {
        socket!.emit(
          'join',
          {
            'name': name,
          },
        );
      },
    );

    socket!.on('message', (data) {
      _streamSocket.addResponse(data);
    });

    socket!.onDisconnect((data) {});

    _streamSocket.getResponse.listen(
      (socketEvent) {
        String timeStamp = DateFormat('yy-MM-dd kk:mm:ss').format(DateTime.now());
        logs.add("[$timeStamp] ${socketEvent['msg']}");
        notifyListeners();
      },
    );
  }

  void close() {
    _streamSocket.dispose();
  }
}
