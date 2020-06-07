import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvp_platform/models/event/doctor_event.dart';
import 'package:mvp_platform/models/enums/event_state.dart';

class EventHeader extends StatelessWidget {
  final DoctorEvent event;

  EventHeader(this.event);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    '${event.startsAt.day}',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: event.eventState.colors().item1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${DateFormat(DateFormat.MONTH).format(event.startsAt)}',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: event.eventState.colors().item1,
                          ),
                        ),
                        Text(
                          '(${DateFormat(DateFormat.WEEKDAY).format(event.startsAt)})',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: event.eventState.colors().item1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: event.eventState == EventState.planned
                ? Container(
                    constraints: BoxConstraints(
                      maxWidth: 105.0,
                    ),
                    child: Text(
                      event.eventState.translate(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: event.eventState.colors().item3,
                        fontSize: 16.0,
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '${event.eventState.translate()}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: event.eventState.colors().item2,
                        ),
                      ),
                      Text(
                        '${DateFormat(DateFormat.HOUR24_MINUTE).format(event.startsAt)} - ${DateFormat(DateFormat.HOUR24_MINUTE).format(event.endsAt)}',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: event.eventState.colors().item2,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
