import 'package:flutter/material.dart';
import 'package:mvp_platform/models/event/doctor_event.dart';
import 'package:mvp_platform/widgets/event/doctor_event.dart' as EventWidget;

class DoctorEventsList extends StatelessWidget {
  final List<DoctorEvent> events;

  DoctorEventsList(this.events);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: events.map((e) => EventWidget.DoctorEvent(e)).toList(),
    );
  }
}
