import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mvp_platform/main.dart';
import 'package:mvp_platform/providers/events/doctor_events.dart';
import 'package:mvp_platform/screens/doctor/doctor_visit_details_screen.dart';
import 'package:mvp_platform/widgets/calendar/tablecalendar/table_calendar.dart';
import 'package:mvp_platform/widgets/event/doctor_event.dart' as EventWidget;
import 'package:provider/provider.dart';

class CalendarScreen extends StatefulWidget {
  static final routeName = '/events-screen';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
    with TickerProviderStateMixin {
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
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

  final defaultTextStyle = const TextStyle(
    fontSize: 17,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting(locale);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Диспансерный учет'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Богатырев Иван Иванович',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Consumer<DoctorEvents>(
            builder: (_, events, __) => Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: TableCalendar(
                onDaySelected: (day, events) {
                  if (events.isNotEmpty) {
                    Navigator.pushNamed(
                      context,
                      DoctorVisitDetailsScreen.routeName,
                      arguments: DoctorVisitDetailsScreenArguments(events[0]),
                    );
                  }
                },
                locale: locale,
                events: events.items,
                initialSelectedDay: DateTime(2020, 5, 9),
                doctorEvents: events,
                calendarController: calendarController,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: defaultTextStyle,
                  weekendStyle: defaultTextStyle,
                ),
                calendarStyle: CalendarStyle(
                  highlightToday: false,
                  selectedColor: null,
                  selectedStyle: defaultTextStyle,
                  outsideDaysVisible: true,
                  highlightSelected: false,
                  weekdayStyle: defaultTextStyle,
                  weekendStyle: defaultTextStyle,
                ),
                headerStyle: HeaderStyle(),
              ),
            ),
          ),
          Expanded(
            child: Consumer<DoctorEvents>(
              builder: (_, events, __) => ListView.builder(
                key: listKey,
                itemCount: events.eventsOfMonth.length,
                itemBuilder: (context, i) =>
                    EventWidget.DoctorEvent(events.eventsOfMonth[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
