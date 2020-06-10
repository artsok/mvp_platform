import 'package:flutter/material.dart';
import 'package:mvp_platform/models/event/doctor_event.dart';
import 'package:mvp_platform/models/enums/event_state.dart';
import 'package:mvp_platform/providers/events/doctor_events.dart';
import 'package:provider/provider.dart';

class DoctorEventDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final event = Provider.of<DoctorEvent>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: event.eventState.colors().item2,
        child: event.doctor == null
            ? Text(event.description)
            : Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              event.doctor.name,
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(event.doctor.profession),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        width: 80.0,
                        height: 80.0,
                        child: ClipRRect(
                          child: Image.asset(event.doctor.photoPath),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(height: 8.0),
                      Expanded(
                        child: Text(
                          event.description,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      if (event.eventState == EventState.complete)
                        GestureDetector(
                          onTap: () {
                            event.eventState = EventState.approved;
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('оценить'),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
