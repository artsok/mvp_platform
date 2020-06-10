import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/models/doctor.dart';
import 'package:mvp_platform/models/enums/event_state.dart';
import 'package:mvp_platform/models/enums/rate.dart';
import 'package:mvp_platform/models/event/doctor_event.dart';
import 'package:mvp_platform/widgets/common/popup_menu.dart';
import 'package:mvp_platform/widgets/common/rate_popup_menu_button.dart';
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
                          child: Consumer<Doctor>(
                            builder: (BuildContext context, Doctor doctor,
                                Widget child) {
                              if (doctor.rating != 0.0) {
                                return Container();
                              }
                              return PopupMenuButton(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Оцените услугу',
                                    style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                itemBuilder: (BuildContext context) {
                                  return [
                                    RatePopupMenu(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Row(
                                          children: <Widget>[
                                            RatePopupMenuButton(
                                              callback: () => doctor.rating =
                                                  Rate.rate1.value.toDouble(),
                                              rate: Rate.rate1,
                                            ),
                                            RatePopupMenuButton(
                                              callback: () => doctor.rating =
                                                  Rate.rate2.value.toDouble(),
                                              rate: Rate.rate2,
                                            ),
                                            RatePopupMenuButton(
                                              callback: () => doctor.rating =
                                                  Rate.rate3.value.toDouble(),
                                              rate: Rate.rate3,
                                            ),
                                            RatePopupMenuButton(
                                              callback: () => doctor.rating =
                                                  Rate.rate4.value.toDouble(),
                                              rate: Rate.rate4,
                                            ),
                                            RatePopupMenuButton(
                                              callback: () => doctor.rating =
                                                  Rate.rate5.value.toDouble(),
                                              rate: Rate.rate5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ];
                                },
                              );
                            },
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
