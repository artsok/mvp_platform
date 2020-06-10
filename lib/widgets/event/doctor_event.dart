import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp_platform/models/event/doctor_event.dart' as EventModel;
import 'package:mvp_platform/screens/doctor/doctor_visit_details_screen.dart';
import 'package:mvp_platform/widgets/event/doctor_event_details.dart';
import 'package:mvp_platform/widgets/event/event_header.dart';
import 'package:provider/provider.dart';

class DoctorEvent extends StatelessWidget {
  final EventModel.DoctorEvent event;

  DoctorEvent(this.event) : assert(event != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        DoctorVisitDetailsScreen.routeName,
        arguments: DoctorVisitDetailsScreenArguments(event),
      ),
      child: ChangeNotifierProvider.value(
        value: event,
        child: Column(
          children: <Widget>[
            EventHeader(),
            DoctorEventDetails(),
          ],
        ),
      ),
    );
  }
}
