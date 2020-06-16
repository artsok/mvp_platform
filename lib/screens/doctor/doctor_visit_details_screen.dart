import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/models/enums/rate.dart';
import 'package:mvp_platform/models/enums/visit_status.dart';
import 'package:mvp_platform/models/hospital.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/repository/response/dto/visit_info.dart';
import 'package:mvp_platform/utils/extensions/datetime_extensions.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
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
    final client = args.client;
    final visit = args.visit;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.of(context).pop("I love Nutella"),
        ),
        title: const Text('Запись на прием'),
      ),
      body: SingleChildScrollView(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: client),
            ChangeNotifierProvider.value(value: visit),
          ],
          child: Column(
            children: <Widget>[
              VisitStatusHeader(visit),
              VisitDateTime(visit),
              PatientInfo(),
              DoctorInfo(),
              MedOrganizationInfo(visit),
              SizedBox(height: 8.0),
              AvailableActions(),
            ],
          ),
        ),
      ),
    );
  }
}

class VisitStatusHeader extends StatelessWidget {
  final VisitExt visit;

  const VisitStatusHeader(this.visit, {Key key}) : super(key: key);

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
                  visit.status.toVisitStatus() == VisitStatus.serviceRegistered
                      ? Icons.event
                      : Icons.check_circle_outline,
                  color: visit.status.toVisitStatus().colors().item1,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      visit.status.toVisitStatus().translate(),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '${visit.planDate.toDmyHm()}',
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
              color: visit.status.toVisitStatus().colors().item1,
            ),
          ),
        ],
      ),
    );
  }
}

class VisitDateTime extends StatelessWidget {
  final VisitExt visit;

  const VisitDateTime(this.visit, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return visit.status.toVisitStatus() == VisitStatus.serviceRegistered
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
                    visit.planDate.toDmyHm(),
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
    final visit = Provider.of<VisitExt>(context);
    return visit.doctor == null
        ? Container()
        : Padding(
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
                          Consumer<VisitExt>(
                            builder: (BuildContext context, VisitExt visit,
                                Widget child) {
                              if (visit.rating != null && visit.rating != 0) {
                                return Icon(
                                  Rate.values[visit.rating.toInt() - 1].icon,
                                  color: Rate
                                      .values[visit.rating.toInt() - 1].color,
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
                        visit.doctor.specialty,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${visit.doctor.lastName} ${visit.doctor.midName} ${visit.doctor.lastName}',
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
                  child: Image.asset(visit.doctor.photoPath),
                )
              ],
            ),
          );
  }
}

class MedOrganizationInfo extends StatelessWidget {
//  final hospital = Hospital(
//    'ГБУЗ "Городская детская поликлиника №4"',
//    'г.Калининград, ул.Садовая д.7/13',
//    'assets/map/dekabristov-24.png',
//  );

  final VisitExt visit;

  MedOrganizationInfo(this.visit, {Key key}) : super(key: key);

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
                      visit.,
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
    final visit = Provider.of<VisitExt>(context);
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
          child: Consumer<VisitExt>(
            builder: (context, visit, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (visit.status.toVisitStatus() !=
                    VisitStatus.serviceCompleted)
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
                if (visit.status.toVisitStatus() !=
                    VisitStatus.serviceCompleted)
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
                if (visit.status.toVisitStatus() ==
                    VisitStatus.serviceCompleted)
                  PopupMenuButton(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Оценить визит',
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
                                callback: () => visit.rating = Rate.rate1.value,
                                rate: Rate.rate1,
                              ),
                              RatePopupMenuButton(
                                callback: () => visit.rating = Rate.rate2.value,
                                rate: Rate.rate2,
                              ),
                              RatePopupMenuButton(
                                callback: () => visit.rating = Rate.rate3.value,
                                rate: Rate.rate3,
                              ),
                              RatePopupMenuButton(
                                callback: () => visit.rating = Rate.rate4.value,
                                rate: Rate.rate4,
                              ),
                              RatePopupMenuButton(
                                callback: () => visit.rating = Rate.rate5.value,
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
  final Client client;
  final VisitExt visit;

  DoctorVisitDetailsScreenArguments(this.client, this.visit);
}
