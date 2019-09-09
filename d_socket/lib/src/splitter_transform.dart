import 'dart:async';
import 'dart:typed_data';

class SplitterTransform extends StreamTransformerBase<Uint8List,Uint8List> {
  var _cache = <int>[];
  var _findIndexs=<int>[];
  var _lastIndex=0;
  final Uint8List split;
  SplitterTransform(this.split);

  @override
  Stream<Uint8List> bind(Stream<Uint8List> stream) {
    var controller = StreamController<Uint8List>();
    Future(() async {
      await for (var data in stream) {
        _cache.addAll(data);
        if(_cache.length<split.length){
          continue;
        }
        _split();
        for(var index in _findIndexs){
          controller.add(Uint8List.fromList(_cache.sublist(0, index)));
          _cache.removeRange(0,index+split.length);
        }
      }
    }).catchError((e) {
      controller.addError(e);
    });

    return controller.stream;
  }
  /*
   * 分隔数据段，处理tcp粘包问题
   * 
   */
  void _split() {
    for (var key in split) {
      var isEquale=true;
      var findIndex=_cache.indexOf(key,_lastIndex);
      if(findIndex>0){
        //截取split长度的数据与split比较
        var tmpCahce = _cache.sublist(_lastIndex,_lastIndex+split.length);
        for(var index=0;index<split.length;index++){
          if(isEquale&&tmpCahce[index]==split[index]){
            continue;
          }
          isEquale=false;
          break;
        }
        if(isEquale){
          _findIndexs.add(findIndex);
          _lastIndex=findIndex+split.length;
        }
      }
    }
  }
}
