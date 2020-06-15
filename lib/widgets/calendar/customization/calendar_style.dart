part of table_calendar;

/// Class containing styling for `TableCalendar`'s content.
class CalendarStyle {

  /// Style of foreground Text for regular weekdays.
  final TextStyle weekdayStyle;

  /// Style of foreground Text for regular weekends.
  final TextStyle weekendStyle;

  /// Style of foreground Text for holidays.
  final TextStyle holidayStyle;

  /// Style of foreground Text for selected day.
  final TextStyle selectedStyle;

  /// Style of foreground Text for today.
  final TextStyle todayStyle;

  /// Style of foreground Text for weekdays outside of current month.
  final TextStyle outsideStyle;

  /// Style of foreground Text for weekends outside of current month.
  final TextStyle outsideWeekendStyle;

  /// Style of foreground Text for holidays outside of current month.
  final TextStyle outsideHolidayStyle;

  /// Style of foreground Text for days outside of `startDay` - `endDay` Date range.
  final TextStyle unavailableStyle;

  final Color selectedColor;
  final Color todayColor;
  final bool outsideDaysVisible;

  /// Determines rendering priority for SelectedDay and Today.
  /// * `true` - SelectedDay will have higher priority than Today
  /// * `false` - Today will have higher priority than SelectedDay
  final bool renderSelectedFirst;

  /// Determines whether the row of days of the week should be rendered or not.
  final bool renderDaysOfWeek;

  /// Padding of `TableCalendar`'s content.
  final EdgeInsets contentPadding;

  /// Specifies whether or not SelectedDay should be highlighted.
  final bool highlightSelected;

  /// Specifies whether or not Today should be highlighted.
  final bool highlightToday;

  const CalendarStyle({
    this.weekdayStyle = const TextStyle(),
    this.weekendStyle = const TextStyle(color: const Color(0xFFF44336)), // Material red[500]
    this.holidayStyle = const TextStyle(color: const Color(0xFFF44336)), // Material red[500]
    this.selectedStyle = const TextStyle(color: const Color(0xFFFAFAFA), fontSize: 16.0), // Material grey[50]
    this.todayStyle = const TextStyle(color: const Color(0xFFFAFAFA), fontSize: 16.0), // Material grey[50]
    this.outsideStyle = const TextStyle(color: const Color(0xFF9E9E9E)), // Material grey[500]
    this.outsideWeekendStyle = const TextStyle(color: const Color(0xFFEF9A9A)), // Material red[200]
    this.outsideHolidayStyle = const TextStyle(color: const Color(0xFFEF9A9A)), // Material red[200]
    this.unavailableStyle = const TextStyle(color: const Color(0xFFBFBFBF)),
    this.selectedColor = const Color(0xFF5C6BC0), // Material indigo[400]
    this.todayColor = const Color(0xFF9FA8DA), // Material indigo[200]
    this.outsideDaysVisible = true,
    this.renderSelectedFirst = true,
    this.renderDaysOfWeek = true,
    this.contentPadding = const EdgeInsets.only(bottom: 4.0, left: 8.0, right: 8.0),
    this.highlightSelected = true,
    this.highlightToday = true,
  });
}
