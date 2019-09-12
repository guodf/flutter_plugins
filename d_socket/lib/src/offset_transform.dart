import 'dart:async';

import 'dart:typed_data';

class OffsetTransform extends StreamTransformerBase<Uint8List, Uint8List> {
  final int offset;
  var _cache = <int>[];
  OffsetTransform(this.offset);

  @override
  Stream<Uint8List> bind(Stream<Uint8List> stream) {
    var controller = StreamController<Uint8List>();
    Future(() async {
      await for (var data in stream) {
        _cache.addAll(data);
        while (_cache.length>offset) {
          var bytes = ByteData.view(
              Uint8List.fromList(_cache.sublist(0, offset)).buffer);
          //数据包的有效长度
          var length = bytes.getUint64(0);
          print("tcp:header:$length,data:${data.length}");
          if (_cache.length < length + offset) {
            break;
          }
          if (length > 0) {
            controller.add(
                Uint8List.fromList(_cache.sublist(offset, length + offset)));
          }
          _cache.removeRange(0, length + offset);
        }
      }
    }).catchError((e) {
      controller.addError(e);
    });

    return controller.stream;
  }
}
