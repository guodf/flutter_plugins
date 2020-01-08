class DurationUtil {
  Duration duration;
  DurationUtil.from(this.duration);

  String toString() {
    return "${_twoDigits(duration.inHours)}:${_twoDigits(duration.inMinutes)}:${_twoDigits(duration.inSeconds % 60)}";
  }

  static String _twoDigits(int num) {
    if (num >= 10) {
      return "${num}";
    }
    return "0${num}";
  }
}
