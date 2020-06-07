import 'package:flutter/material.dart';
import 'package:mvp_platform/providers/events/doctor_events.dart';
import 'package:mvp_platform/widgets/event/doctor_event.dart' as EventWidget;

class DoctorEventsList extends StatelessWidget {
  final DoctorEvents events;

  DoctorEventsList(this.events);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          events.allEvents.map((e) => EventWidget.DoctorEvent(e)).toList(),
    );
  }
}
