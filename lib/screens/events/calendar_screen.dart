import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mvp_platform/main.dart';
import 'package:mvp_platform/models/enums/response_status.dart';
import 'package:mvp_platform/providers/visits_info/visits_info_data.dart';
import 'package:mvp_platform/providers/visits_info/visits_info_provider.dart';
import 'package:mvp_platform/screens/doctor/doctor_visit_details_screen.dart';
import 'package:mvp_platform/widgets/calendar/tablecalendar/table_calendar.dart';
import 'package:mvp_platform/widgets/doctor_visit_item/doctor_visit_item.dart';
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
    final visitsInfo = VisitsInfoProvider();
    return MultiProvider(
      providers: [
        FutureProvider(create: (_) => visitsInfo.fetchData()),
        FutureProvider(create: (_) => visitsInfo.data),
      ],
      child: Scaffold(
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
            Consumer<VisitsInfoProvider>(builder: (_, visitsInfo, __) {
              if (visitsInfo == null) {
                return Container(
                  width: double.infinity,
                  child: CupertinoActivityIndicator(radius: 25.0),
                );
              } else {
                switch (visitsInfo.data.responseStatus) {
                  case ResponseStatus.success:
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TableCalendar(
                        onDaySelected: (day, visits) {
                          if (visits.isNotEmpty) {
                            Navigator.pushNamed(
                              context,
                              DoctorVisitDetailsScreen.routeName,
                              arguments: DoctorVisitDetailsScreenArguments(
                                visitsInfo.data.client,
                                visits[0],
                              ),
                            );
                          }
                        },
                        locale: locale,
                        visits: visitsInfo.data,
                        client: visitsInfo.data.client,
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
                    );
                  case ResponseStatus.error:
                    return Center(
                      child: const Text(
                        'Ошибка при загрузке данных',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.red,
                        ),
                      ),
                    );
                  default:
                    return CupertinoActivityIndicator(radius: 25.0);
                }
              }
            }),
            Expanded(
              child: Consumer<VisitsInfoData>(
                builder: (_, visitsInfoData, __) {
                  if (visitsInfoData == null) {
                    return CupertinoActivityIndicator(radius: 25.0);
                  } else {
                    switch (visitsInfoData.responseStatus) {
                      case ResponseStatus.success:
                        return ListView.builder(
                          key: listKey,
                          itemCount: visitsInfoData.visitsOfMonth.length,
                          itemBuilder: (context, i) =>
                              ChangeNotifierProvider.value(
                            value: visitsInfoData.visitsOfMonth[i],
                            child: DoctorVisitItem(
                              visitsInfoData.client,
                              visitsInfoData.visitsOfMonth[i],
                            ),
                          ),
                        );
                      case ResponseStatus.error:
                        return Center(
                          child: const Text(
                            'Ошибка при загрузке данных',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.red,
                            ),
                          ),
                        );
                      default:
                        return CupertinoActivityIndicator(radius: 25.0);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
