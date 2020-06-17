import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/models/enums/rate.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/providers/request/rating_provider.dart';
import 'package:mvp_platform/providers/request/visit_ext_provider.dart';
import 'package:provider/provider.dart';

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<RatingProvider, VisitExtProvider>(
      builder: (_, rating, visitExt, __) {
        final visit = visitExt.visitExt;
        if (visit == null) {
          return Container(
            width: double.infinity,
            child: const Text('Нет информации о посещении'),
          );
        }
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
                      '${visit.doctor.lastName} ${visit.doctor.firstName} ${visit.doctor.midName}',
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
