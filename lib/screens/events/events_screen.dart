import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/providers/events/doctor_events.dart';
import 'package:mvp_platform/widgets/calendar/calendar.dart';
import 'package:mvp_platform/widgets/event/doctor_events_list.dart';
import 'package:provider/provider.dart';

class EventsScreen extends StatefulWidget {
  static final routeName = '/events-screen';

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Диспансерный учет'),
      ),
      body: SingleChildScrollView(
        child: Consumer<DoctorEvents>(
          builder: (_, events, __) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Богатырев Иван Иванович',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Calendar(),
              DoctorEventsList(events.events),
            ],
          ),
        ),
      ),
    );
  }
}
