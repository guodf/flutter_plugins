import 'dart:math';

class VersionUtil {
  static int compare(String v1, String v2) {
    var v1Arr = v1.split(".");
    var v2Arr = v2.split(".");
    var v1Len = v1Arr.length;
    var v2Len = v2Arr.length;
    final len = min(v1Len, v2Len);
    for (var index = 0; index < len; index++) {
      final item1 = int.tryParse(v1Arr[index]);
      final item2 = int.tryParse(v2Arr[index]);
      if (item1 == item2) {
        continue;
      }
      if (item1 > item2) {
        return 1;
      }
      return -1;
    }
    return v1Len > v2Len ? 1 : v1Len < v2Len ? -1 : 0;
  }
}
