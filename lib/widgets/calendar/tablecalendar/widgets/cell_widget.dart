part of table_calendar;

class _CellWidget extends StatelessWidget {
  final String text;
  final bool isUnavailable;
  final bool isSelected;
  final bool isToday;
  final bool isWeekend;
  final bool isOutsideMonth;
  final bool isHoliday;

  final bool hasEventOnPreviousDay;
  final bool hasEventOnNextDay;

  final CalendarStyle calendarStyle;

  const _CellWidget({
    Key key,
    @required this.text,
    this.isUnavailable = false,
    this.isSelected = false,
    this.isToday = false,
    this.isWeekend = false,
    this.isOutsideMonth = false,
    this.isHoliday = false,
    this.hasEventOnPreviousDay = false,
    this.hasEventOnNextDay = false,
    @required this.calendarStyle,
  })  : assert(text != null),
        assert(calendarStyle != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {

    final event = Provider.of<DoctorEvent>(context);
    final eventState = event?.eventState;

    return LayoutBuilder(
      builder: (_, constraints) => AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: _buildCellDecoration(constraints, eventState),
        margin: EdgeInsets.only(
          top: 6.0,
          bottom: 6.0,
          left: hasEventOnPreviousDay && eventState != null ? 0.0 : 6.0,
          right: hasEventOnNextDay && eventState != null ? 0.0 : 6.0,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: _buildCellTextStyle(),
        ),
      ),
    );
  }

  Decoration _buildCellDecoration(BoxConstraints constraints, EventState eventState) {
    if (eventState != null) {
      return BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: hasEventOnPreviousDay
              ? Radius.zero
              : Radius.circular(constraints.maxWidth / 2),
          bottomLeft: hasEventOnPreviousDay
              ? Radius.zero
              : Radius.circular(constraints.maxWidth / 2),
          topRight: hasEventOnNextDay
              ? Radius.zero
              : Radius.circular(constraints.maxWidth / 2),
          bottomRight: hasEventOnNextDay
              ? Radius.zero
              : Radius.circular(constraints.maxWidth / 2),
        ),
        color: eventState.colors().item2,
        boxShadow: <BoxShadow>[
//          BoxShadow(
//            color: Colors.black12,
//            blurRadius: constraints.maxWidth / 2,
//            offset: Offset(0.0, constraints.maxWidth / 2),
//          ),
        ],
      );
    }
    if (isSelected &&
        calendarStyle.renderSelectedFirst &&
        calendarStyle.highlightSelected) {
      return BoxDecoration(
        shape: BoxShape.circle,
        color: calendarStyle.selectedColor,
      );
    } else if (isToday && calendarStyle.highlightToday) {
      return BoxDecoration(
        shape: BoxShape.circle,
        color: calendarStyle.todayColor,
      );
    } else if (isSelected && calendarStyle.highlightSelected) {
      return BoxDecoration(
        shape: BoxShape.circle,
        color: calendarStyle.selectedColor,
      );
    } else {
      return BoxDecoration(shape: BoxShape.circle);
    }
  }

  TextStyle _buildCellTextStyle() {
    if (isUnavailable) {
      return calendarStyle.unavailableStyle;
    } else if (isSelected &&
        calendarStyle.renderSelectedFirst &&
        calendarStyle.highlightSelected) {
      return calendarStyle.selectedStyle;
    } else if (isToday && calendarStyle.highlightToday) {
      return calendarStyle.todayStyle;
    } else if (isSelected && calendarStyle.highlightSelected) {
      return calendarStyle.selectedStyle;
    } else if (isOutsideMonth && isHoliday) {
      return calendarStyle.outsideHolidayStyle;
    } else if (isHoliday) {
      return calendarStyle.holidayStyle;
    } else if (isOutsideMonth && isWeekend) {
      return calendarStyle.outsideWeekendStyle;
    } else if (isOutsideMonth) {
      return calendarStyle.outsideStyle;
    } else if (isWeekend) {
      return calendarStyle.weekendStyle;
    } else {
      return calendarStyle.weekdayStyle;
    }
  }
}
