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
        var bytes = ByteData.view(
            Uint8List.fromList(_cache.sublist(offset, offset + 8)).buffer);
        var length = bytes.getUint64(0);

        if (_cache.length < length - 8) {
          continue;
        }
        controller.add(_cache.sublist(9, length));
        _cache.removeRange(0, length + 8);
      }
    }).catchError((e) {
      controller.addError(e);
    });

    return controller.stream;
  }
}
