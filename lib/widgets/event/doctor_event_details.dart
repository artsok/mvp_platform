import 'package:flutter/material.dart';
import 'package:mvp_platform/models/event/doctor_event.dart';
import 'package:mvp_platform/models/enums/event_state.dart';

class DoctorEventDetails extends StatelessWidget {
  final DoctorEvent event;

  DoctorEventDetails(this.event);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: event.eventState.colors().item2,
        child: event.doctor == null
            ? Text(event.description)
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          event.doctor.name,
                          style: TextStyle(fontSize: 24.0),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    height: 100.0,
                    child: ClipRRect(
                      child: Image.asset(event.doctor.photoPath),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
