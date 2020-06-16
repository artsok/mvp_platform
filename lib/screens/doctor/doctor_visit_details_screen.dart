import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/models/enums/rate.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/models/enums/visit_status.dart';
import 'package:mvp_platform/models/hospital.dart';
import 'package:mvp_platform/providers/request/rating_provider.dart';
import 'package:mvp_platform/providers/request/visit_ext_provider.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/repository/response/dto/visit_info.dart';
import 'package:mvp_platform/utils/extensions/datetime_extensions.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/common/gos_cupertino_loading_indicator.dart';
import 'package:mvp_platform/widgets/common/popup_menu.dart';
import 'package:mvp_platform/widgets/common/rate_popup_menu_button.dart';
import 'package:provider/provider.dart';

class DoctorVisitDetailsScreen extends StatefulWidget {
  static final routeName = '/doctor-visit-details-screen';

  DoctorVisitDetailsScreen({Key key}) : super(key: key);

  @override
  _DoctorVisitDetailsScreenState createState() =>
      _DoctorVisitDetailsScreenState();
}

class _DoctorVisitDetailsScreenState extends State<DoctorVisitDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final DoctorVisitDetailsScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    final client = args.client;
    final visit = args.visit;
    final RatingProvider rating = RatingProvider();
    final VisitExtProvider visitExt = VisitExtProvider();
    visitExt.fetchData(visit.id);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.of(context).pop("I love Nutella"),
        ),
        title: const Text('Запись на прием'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: SafeArea(
          child: SingleChildScrollView(
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: client),
                ChangeNotifierProvider.value(value: visit),
                ChangeNotifierProvider.value(value: rating),
                ChangeNotifierProvider.value(value: visitExt),
              ],
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    VisitStatusHeader(visit),
                    VisitDateTime(visit),
                    PatientInfo(),
                    DoctorInfo(),
                    MedOrganizationInfo(visit),
                    SizedBox(height: 8.0),
                    AvailableActions(),
                    Comment(),
                  ],
                ),
              ),
            ),
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
    return Consumer3<VisitExt, RatingProvider, VisitExtProvider>(
      builder: (_, visit, rating, visitExt, __) {
        if (visit.doctor == null) {
          return Container();
        }
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
                        visit.rating != null &&
                                visit.rating != 0 &&
                                (rating.requestStatus == RequestStatus.ready ||
                                    rating.requestStatus ==
                                        RequestStatus.success ||
                                    rating.requestStatus == RequestStatus.error)
                            ? Icon(
                                Rate
                                    .values[visitExt.requestStatus !=
                                            RequestStatus.success
                                        ? visit.rating - 1
                                        : visitExt.visitExt.rating - 1]
                                    .icon,
                                color: Rate
                                    .values[visitExt.requestStatus !=
                                            RequestStatus.success
                                        ? visit.rating - 1
                                        : visitExt.visitExt.rating - 1]
                                    .color,
                              )
                            : Container(),
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
      },
    );
  }
}

class MedOrganizationInfo extends StatelessWidget {
  final hospital = Hospital(
    'ГБУЗ "Городская детская поликлиника №4"',
    'г.Калининград, ул.Садовая д.7/13',
    'assets/map/dekabristov-24.png',
  );

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
          child: Consumer2<VisitExt, RatingProvider>(
              builder: (_, visit, rating, __) {
            if (visit.status.toVisitStatus() == VisitStatus.serviceCompleted) {
              if (visit.rating != null) {
//                return Container();
              }
              if (rating.requestStatus == RequestStatus.error ||
                  rating.requestStatus == RequestStatus.ready) {
                if (rating.requestStatus == RequestStatus.error) {
//                  Scaffold.of(context).showSnackBar(
//                    SnackBar(
//                      content: Text('Ошибка: ${rating.errorMessage}'),
//                    ),
//                  );
                }
                return _buildRateButton(visit, rating);
              }
              if (rating.requestStatus == RequestStatus.success) {
//                return Container();
                return _buildRateButton(visit, rating);
              }
              return const GosCupertinoLoadingIndicator();
            } else {
              return Column(
                children: <Widget>[
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
                ],
              );
            }
          }),
        ),
      ],
    );
  }

  Widget _buildRateButton(VisitExt visit, RatingProvider rating) {
    return PopupMenuButton(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Оцените услугу',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.blue[600],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      itemBuilder: (_) => [
        RatePopupMenu(
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Row(
              children: <Widget>[
                RatePopupMenuButton(
                  callback: () {
                    rating.setRating(visit.id, Rate.rate1.value);
                    VisitExtProvider().fetchData(visit.id);
                  },
                  size: 32.0,
                  rate: Rate.rate1,
                ),
                RatePopupMenuButton(
                  callback: () {
                    rating.setRating(visit.id, Rate.rate2.value);
                    VisitExtProvider().fetchData(visit.id);
                  },
                  size: 32.0,
                  rate: Rate.rate2,
                ),
                RatePopupMenuButton(
                  callback: () {
                    rating.setRating(visit.id, Rate.rate3.value);
                    VisitExtProvider().fetchData(visit.id);
                  },
                  size: 32.0,
                  rate: Rate.rate3,
                ),
                RatePopupMenuButton(
                  callback: () {
                    rating.setRating(visit.id, Rate.rate4.value);
                    VisitExtProvider().fetchData(visit.id);
                  },
                  size: 32.0,
                  rate: Rate.rate4,
                ),
                RatePopupMenuButton(
                  callback: () {
                    rating.setRating(visit.id, Rate.rate5.value);
                    VisitExtProvider().fetchData(visit.id);
                  },
                  size: 32.0,
                  rate: Rate.rate5,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Comment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<VisitExtProvider>(
      builder: (_, visitExt, __) {
        if (visitExt.requestStatus == RequestStatus.processing) {
          return Center(child: const GosCupertinoLoadingIndicator());
        }
        if (visitExt.requestStatus == RequestStatus.error ||
            visitExt.requestStatus == RequestStatus.ready) {
          if (visitExt.requestStatus == RequestStatus.error) {
//            Scaffold.of(context).showSnackBar(
//              SnackBar(
//                content: Text('Ошибка: ${visitExt.errorMessage}'),
//              ),
//            );
            return _buildCommentTextField(visitExt.visitExt);
          }
        } else {
        }
        return Container();
      },
    );
  }

  Widget _buildCommentTextField(VisitExt visitExt) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: const Text(
                'Ваш комментарий:',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(height: 4.0),
            TextField(
              enabled: visitExt?.ratingComment == null ||
                  visitExt.ratingComment == '',
              maxLines: 2,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DoctorVisitDetailsScreenArguments {
  final Client client;
  final VisitExt visit;

  DoctorVisitDetailsScreenArguments(this.client, this.visit);
}
