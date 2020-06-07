import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp_platform/models/event/doctor_event.dart' as EventModel;
import 'package:mvp_platform/widgets/event/doctor_event_details.dart';
import 'package:mvp_platform/widgets/event/event_header.dart';

class DoctorEvent extends StatelessWidget {
  final EventModel.DoctorEvent event;

  DoctorEvent(this.event) : assert(event != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        EventHeader(event),
        DoctorEventDetails(event),
      ],
    );
  }
}
