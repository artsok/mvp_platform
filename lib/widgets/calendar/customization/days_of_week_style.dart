part of table_calendar;

class DaysOfWeekStyle {

  final TextBuilder dowTextBuilder;
  final TextStyle weekdayStyle;
  final TextStyle weekendStyle;

  const DaysOfWeekStyle({
    this.dowTextBuilder,
    this.weekdayStyle = const TextStyle(color: const Color(0xFF616161)), // Material grey[700]
    this.weekendStyle = const TextStyle(color: const Color(0xFFF44336)), // Material red[500]
  });
}
