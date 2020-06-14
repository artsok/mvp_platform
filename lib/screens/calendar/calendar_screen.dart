import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mvp_platform/main.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/providers/request/visits_info_provider.dart';
import 'package:mvp_platform/screens/doctor/doctor_visit_details_screen.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/calendar/tablecalendar/table_calendar.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/gos_cupertino_loading_indicator.dart';
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
  CalendarController calendarController;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    calendarController = CalendarController();
  }

  @override
  void dispose() {
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
    if (visitsInfo.visits.isEmpty) {
      visitsInfo.fetchData();
    }

    return ChangeNotifierProvider.value(
      value: visitsInfo,
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
            Consumer<VisitsInfoProvider>(builder: (_, visitsInfo, __) {
              return Column(
                children: <Widget>[
                  visitsInfo.client == null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            visitsInfo.client.fullName,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TableCalendar(
                      onDaySelected: (day, visits) {
                        if (visits.isNotEmpty) {
                          Navigator.pushNamed(
                            context,
                            DoctorVisitDetailsScreen.routeName,
                            arguments: DoctorVisitDetailsScreenArguments(
                              visitsInfo.client,
                              visits[0],
                            ),
                          );
                        }
                      },
                      locale: locale,
                      visitsInfo: visitsInfo,
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
                      headerStyle: HeaderStyle(
                        headerPadding: const EdgeInsets.all(0.0),
                        headerMargin: const EdgeInsets.all(0.0),
                      ),
                    ),
                  ),
                ],
              );
            }),
            Expanded(
              child: Consumer<VisitsInfoProvider>(
                builder: (_, visitsInfoData, __) {
                  if (visitsInfoData == null) {
                    return CupertinoActivityIndicator(radius: 25.0);
                  } else {
                    switch (visitsInfoData.requestStatus) {
                      case RequestStatus.success:
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
                      case RequestStatus.error:
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Возникла ошибка',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                visitsInfoData.errorMessage,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              GosFlatButton(
                                textColor: Colors.white,
                                backgroundColor: getGosBlueColor(),
                                onPressed: () => visitsInfoData.fetchData(),
                                text: 'Попробовать снова',
                                width: 320,
                              ),
                            ],
                          ),
                        );
                      default:
                        return const GosCupertinoLoadingIndicator();
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
