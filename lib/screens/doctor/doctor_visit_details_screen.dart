import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvp_platform/models/doctor.dart';
import 'package:mvp_platform/models/enums/event_state.dart';
import 'package:mvp_platform/models/enums/rate.dart';
import 'package:mvp_platform/models/event/doctor_event.dart';
import 'package:mvp_platform/models/hospital.dart';
import 'package:mvp_platform/widgets/common/popup_menu.dart';
import 'package:mvp_platform/widgets/common/rate_popup_menu_button.dart';
import 'package:provider/provider.dart';

class DoctorVisitDetailsScreen extends StatelessWidget {
  static final routeName = '/doctor-visit-details-screen';

  DoctorVisitDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DoctorVisitDetailsScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    final DoctorEvent event = args.event;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Запись на прием'),
      ),
      body: SingleChildScrollView(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: event),
            ChangeNotifierProvider.value(value: event.doctor),
          ],
          child: Column(
            children: <Widget>[
              VisitStateHeader(event),
              VisitDateTime(event),
              PatientInfo(),
              DoctorInfo(),
              HospitalInfo(),
              SizedBox(height: 8.0),
              AvailableActions(),
            ],
          ),
        ),
      ),
    );
  }
}

class VisitStateHeader extends StatelessWidget {
  final DoctorEvent event;

  const VisitStateHeader(this.event, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  event.eventState == EventState.planned
                      ? Icons.event
                      : Icons.check_circle_outline,
                  color: event.eventState.colors().item1,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      event.eventState.translate(),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '${DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now())}',
                      style: TextStyle(color: Colors.black54),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              CupertinoIcons.forward,
              color: event.eventState.colors().item1,
            ),
          ),
        ],
      ),
    );
  }
}

class VisitDateTime extends StatelessWidget {
  final DoctorEvent event;

  const VisitDateTime(this.event, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return event.eventState == EventState.planned
        ? Container()
        : Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Дата и время записи',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    DateFormat('dd.MM.yyyy HH:mm').format(event.startsAt),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          );
  }
}

class PatientInfo extends StatelessWidget {
  const PatientInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Пациент',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 4.0),
            const Text(
              'Богатырев Иван Иванович',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doctor = Provider.of<Doctor>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Consumer<Doctor>(
                      builder:
                          (BuildContext context, Doctor doctor, Widget child) {
                        if (doctor.rating != 0.0) {
                          return Icon(
                            Rate.values[doctor.rating.toInt() - 1].icon,
                            color: Rate.values[doctor.rating.toInt() - 1].color,
                          );
                        }
                        return Container();
                      },
                    ),
                    const Text(
                      'Врач',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Text(
                  doctor.profession,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  doctor.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 95.0,
            height: 95.0,
            child: Image.asset(doctor.photoPath),
          )
        ],
      ),
    );
  }
}

class HospitalInfo extends StatelessWidget {
  final hospital = Hospital(
    'ГБУЗ "Городская детская поликлиника №4"',
    'г.Калининград, ул.Садовая д.7/13',
    'assets/map/dekabristov-24.png',
  );

  HospitalInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Лечебное учреждение',
            style: TextStyle(color: Colors.black54),
          ),
          SizedBox(height: 4.0),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      hospital.name,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      hospital.address,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.location_on,
                color: Colors.blue[700],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AvailableActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final doctor = Provider.of<Doctor>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          color: Colors.black12,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: const Text(
              'Доступные действия',
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Consumer<DoctorEvent>(
            builder: (context, event, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (event.eventState != EventState.complete)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Отменить запись',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (event.eventState != EventState.complete)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Перенести запись',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (event.eventState == EventState.complete)
                  PopupMenuButton(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Оценить специалиста',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.blue[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    itemBuilder: (BuildContext context) => [
                      RatePopupMenu(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Row(
                            children: <Widget>[
                              RatePopupMenuButton(
                                callback: () =>
                                    doctor.rating = Rate.rate1.value.toDouble(),
                                rate: Rate.rate1,
                              ),
                              RatePopupMenuButton(
                                callback: () =>
                                    doctor.rating = Rate.rate2.value.toDouble(),
                                rate: Rate.rate2,
                              ),
                              RatePopupMenuButton(
                                callback: () =>
                                    doctor.rating = Rate.rate3.value.toDouble(),
                                rate: Rate.rate3,
                              ),
                              RatePopupMenuButton(
                                callback: () =>
                                    doctor.rating = Rate.rate4.value.toDouble(),
                                rate: Rate.rate4,
                              ),
                              RatePopupMenuButton(
                                callback: () =>
                                    doctor.rating = Rate.rate5.value.toDouble(),
                                rate: Rate.rate5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DoctorVisitDetailsScreenArguments {
  final DoctorEvent event;

  DoctorVisitDetailsScreenArguments(this.event);
}
