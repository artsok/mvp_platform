import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/models/enums/visit_status.dart';
import 'package:mvp_platform/providers/request/visit_ext_provider.dart';
import 'package:provider/provider.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/utils/extensions/datetime_extensions.dart';

class VisitStatusHeader extends StatelessWidget {
  const VisitStatusHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<VisitExtProvider>(
        builder: (_, visitExt, __) {
          if (visitExt.visitExt == null) {
            return Container(
              width: double.infinity,
              child: const Text('Нет информации о посещении'),
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      visitExt.visitExt.status.toVisitStatus() ==
                              VisitStatus.serviceRegistered
                          ? Icons.event
                          : Icons.check_circle_outline,
                      color: visitExt.visitExt.status.toVisitStatus().colors().item1,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          visitExt.visitExt.status.toVisitStatus().translate(),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '${visitExt.visitExt.planDate.toDmyHm()}',
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
                  color: visitExt.visitExt.status.toVisitStatus().colors().item1,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
