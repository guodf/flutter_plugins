class StringUtil {
  static bool isNull(String str)=> str == null;

  static bool isNullOrEmpty(String str) => isNull(str) || str.isEmpty;

  static bool isNullOrWhiteSpace(String str) => isNullOrEmpty(str) || str.trim().length == 0;
}
