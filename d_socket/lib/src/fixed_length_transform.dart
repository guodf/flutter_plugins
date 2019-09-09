import 'dart:async';

import 'dart:typed_data';

class FixedLengthTransform extends StreamTransformerBase<Uint8List, Uint8List> {
  final int length;
  List _cache = <int>[];
  FixedLengthTransform(this.length);

  @override
  Stream<Uint8List> bind(Stream<Uint8List> stream) {
    var controller = StreamController<Uint8List>();
    Future(() async {
      try {
        await for (var data in stream) {
          _cache.addAll(data);
          if (_cache.length < length) {
            continue;
          }
          controller.add(Uint8List.fromList(_cache.sublist(0, length)));
          _cache.removeRange(0, length);
        }
      } catch (e) {
        controller.addError(e);
      }
    });

    return controller.stream;
  }
}
