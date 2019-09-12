import 'dart:io';

import 'package:d_socket/src/fixed_length_transform.dart';

main(List<String> args) async {
  var server = await ServerSocket.bind(InternetAddress("194.168.1.7"), 33333);
  print("start server....");
  await for (var socket in server) {
    acceptSocket(socket);
  }
}

acceptSocket(Socket socket) async {
  try {
    await for (var data in socket.transform(FixedLengthTransform(5))) {
      print("server:$data");
      send(socket, data);
    }
  } catch (e) {
    print(e);
  }
}

send(Socket socket, data) async {
  sleep(Duration(seconds: 3));
  try {
    socket.add(data);
    await socket.flush();
  } catch (e) {
    print(e);
  }
}
