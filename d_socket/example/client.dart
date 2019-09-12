import 'dart:async';
import 'dart:io';

import 'package:d_socket/src/fixed_length_transform.dart';

main(List<String> args) async {
  var client = await Socket.connect(InternetAddress("194.168.1.7"), 33333)
      .timeout(Duration(seconds: 3));
  Timer.periodic(Duration(seconds: 1), (timer) async {
    print(timer.isActive);
    try {
      client.add([timer.tick]);
      await client.flush();
    } catch (e) {
      print(e);
    }
  });
  try {
    await for (var data in client.transform(FixedLengthTransform(5))) {
      print("clinet:$data");
      send(client, data);
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
