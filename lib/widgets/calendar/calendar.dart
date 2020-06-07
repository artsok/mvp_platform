import 'package:flutter/material.dart';
import 'package:mvp_platform/providers/events/doctor_events.dart';
import 'package:mvp_platform/widgets/calendar/tablecalendar/table_calendar.dart';
import 'package:provider/provider.dart';

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
    return Consumer<DoctorEvents>(
      builder: (_, events, __) => TableCalendar(
        events: events.items,
        calendarController: calendarController,
        availableGestures: AvailableGestures.horizontalSwipe,
        calendarStyle: CalendarStyle(),
        headerStyle: HeaderStyle(
          centerHeaderTitle: true,
        ),
      ),
    );
  }
}
