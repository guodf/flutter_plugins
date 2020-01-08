enum StorageUnitType { bit, byte, kb, mb, gb, tb }

class StorageUnitUtil {
  static const int bit = 1;
  static const int bitPerbyte = 8;
  static const int bytePerkb = 1000;
  static const int bytePermb = bytePerkb * 1000;
  static const int bytePergb = bytePermb * 1000;
  static const int bytePertb = bytePergb * 1000;



  final int size;
  double _size;
  StorageUnitUtil.fromByte(this.size);
  StorageUnitUtil.fromMb(int size) : this.fromByte(size * bytePermb);
  StorageUnitUtil.fromGb(int size) : this.fromMb(size * bytePergb);

  /**
   *  Returns dynamic is `length==0? int : double`
   */
  dynamic toKb({int length=0}) {
    return length==0? _toInt():_toFixd(length);
  }

  /**
   *  Returns dynamic is `length==0? int : double`
   */
  dynamic toMb({int length=0}) {
    return length==0? _toInt():_toFixd(length);
  }

  /**
   *  Returns dynamic is `length==0? int : double`
   */
  dynamic toGb({int length=0}) {
    return length==0? _toInt():_toFixd(length);
  }

  /**
   *  Returns dynamic is `length==0? int : double`
   */
  dynamic toTb({int length=0}) {
    return length==0? _toInt():_toFixd(length);
  }

  /**
   * Returns `round()` 
   */
  int _toInt() {
    return _size.round();
  }

  /**
   * `assert(length>0)`
   * 
   * Returns `[_size].round()*10*length/10*length`
   */
  double _toFixd(int length) {
    return _size * 10 * length.round() / 10 * length;
  }

  /**
   * if > TB Returns `TB`
   * 
   * if > GB Returns `GB`
   * 
   * if > MB Returns `MB`
   * 
   * if > KB Returns `KB`
   * 
   * else Returns `B`
   */
  @override
  String toString() {
    if (size > bytePertb) {
      return "${(size / bytePertb).toStringAsFixed(2)}TB";
    }
    if (size > bytePergb) {
      return "${(size / bytePergb).toStringAsFixed(2)}GB";
    }
    if (size > bytePermb) {
      return "${(size / bytePermb).toStringAsFixed(2)}MB";
    }
    if (size > bytePerkb) {
      return "${(size / bytePerkb).toStringAsFixed(2)}KB";
    }
    return "${size}B";
  }
}
