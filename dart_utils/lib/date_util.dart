class DateTimeUtil implements Comparable<DateTimeUtil> {
  DateTime dateTime;

  DateTimeUtil.from(this.dateTime);

  DateTimeUtil.fromSeconds(int seconds, {bool isUtc = false}) {
    dateTime =
        DateTime.fromMillisecondsSinceEpoch(seconds * 1000, isUtc: isUtc);
  }

  DateTimeUtil.now(){
    dateTime=DateTime.now();
  }

  DateTimeUtil.fromMillisecondsSinceEpoch(int millisecondsSinceEpoch,
      {bool isUtc = false}) {
    dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch,
        isUtc: isUtc);
  }

  DateTimeUtil get date =>
      DateTimeUtil.fromMillisecondsSinceEpoch(milliseconds ~/
          Duration.millisecondsPerDay *
          Duration.millisecondsPerDay);

  int get milliseconds => dateTime.millisecondsSinceEpoch;

  int get seconds => milliseconds ~/ 1000;

  String toString() {
    return dateTime.toString();
  }

  String toDateString({String separate = "/"}) {
    return "${dateTime.year}${separate}${_twoDigits(dateTime.month)}${separate}${_twoDigits(dateTime.day)}";
  }

  String toDataStringByRegional(){
    return "${dateTime.year}年${dateTime.month}月${dateTime.day}日";
  }

  @override
  int compareTo(DateTimeUtil other) {
    return dateTime.compareTo(other.dateTime);
  }

  bool operator ==(dynamic other) {
    if (other is DateTimeUtil) {
      return dateTime == other.dateTime;
    }
    throw Exception("other not's DateTimeUtil");
  }

  @override
  int get hashCode {
    return dateTime.hashCode;
  }
  static String _twoDigits(int num) {
    if(num >= 10){
      return "${num}";
    }
    return "0${num}";
  }
}
