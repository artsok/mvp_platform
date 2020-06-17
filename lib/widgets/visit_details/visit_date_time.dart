import 'package:flutter/material.dart';
import 'package:mvp_platform/models/enums/visit_status.dart';
import 'package:mvp_platform/providers/request/visit_ext_provider.dart';
import 'package:provider/provider.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/utils/extensions/datetime_extensions.dart';

class VisitDateTime extends StatelessWidget {
  const VisitDateTime({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<VisitExtProvider>(builder: (_, visitExt, __) {
      if (visitExt.visitExt == null) {
        return Container(
          width: double.infinity,
          child: const Text('Нет информации о времени посещения'),
        );
      }
      if (visitExt.visitExt.status.toVisitStatus() ==
          VisitStatus.serviceRegistered) {
        return Container();
      }
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
                'Дата и время записи',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                visitExt.visitExt.planDate.toDmyHm(),
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
