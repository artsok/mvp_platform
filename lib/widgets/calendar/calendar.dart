import 'package:flutter/material.dart';
import 'package:mvp_platform/main.dart';
import 'package:mvp_platform/providers/events/doctor_events.dart';
import 'package:mvp_platform/widgets/calendar/tablecalendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> with TickerProviderStateMixin {
  AnimationController animationController;
  CalendarController calendarController;

  @override
  void initState() {
    super.initState();

    calendarController = CalendarController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting(locale);
    return Consumer<DoctorEvents>(
      builder: (_, events, __) => TableCalendar(
        locale: locale,
        events: events.items,
        calendarController: calendarController,
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: const TextStyle(
            fontSize: 17,
            color: Colors.black,
          ),
          weekendStyle: const TextStyle(
            fontSize: 17,
            color: Colors.black,
          ),
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          highlightSelected: true,
          weekdayStyle: const TextStyle(
            fontSize: 17,
            color: Colors.black,
          ),
          weekendStyle: const TextStyle(
            fontSize: 17,
            color: Colors.black,
          ),
        ),
        headerStyle: HeaderStyle(),
      ),
    );
  }
}
