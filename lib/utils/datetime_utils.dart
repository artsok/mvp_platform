class DateTimeUtils {
  static List<DateTime> range(DateTime from, DateTime to, Duration interval) {
    DateTime currentDate = from;
    List<DateTime> range = [from];
    while (currentDate.millisecondsSinceEpoch <= to.millisecondsSinceEpoch) {
      range.add(currentDate);
      currentDate = currentDate.add(interval);
    }
    return range;
  }
}
