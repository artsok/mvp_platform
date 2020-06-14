import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mvp_platform/main.dart';
import 'package:mvp_platform/models/enums/rate.dart';
import 'package:mvp_platform/models/enums/visit_status.dart';
import 'package:mvp_platform/repository/response/dto/visit_info.dart';
import 'package:mvp_platform/utils/extensions/datetime_extensions.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:provider/provider.dart';

class DoctorVisitItemHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting(locale);
    final visit = Provider.of<VisitExt>(context);
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
                    '${visit.planDate.day}',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: visit.status.toVisitStatus().colors().item1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${visit.planDate.toMonth()}',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: visit.status.toVisitStatus().colors().item1,
                          ),
                        ),
                        Text(
                          '(${visit.planDate.toWeekday()})',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: visit.status.toVisitStatus().colors().item1,
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
            child: visit.status.toVisitStatus() == VisitStatus.serviceRegistered
                ? Container(
                    constraints: BoxConstraints(
                      maxWidth: 105.0,
                    ),
                    child: Text(
                      visit.status.toVisitStatus().translate(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: visit.status.toVisitStatus().colors().item3,
                        fontSize: 16.0,
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '${visit.status.toVisitStatus().translate()}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: visit.status.toVisitStatus().colors().item3,
                        ),
                      ),
                      Consumer<VisitExt>(
                        builder: (BuildContext context, VisitExt visit,
                            Widget child) {
                          return Row(
                            children: <Widget>[
                              Text(
                                '${visit.planDate.toH24m()} - ${visit.planDate.add(Duration(minutes: 30)).toH24m()}',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: visit.status
                                      .toVisitStatus()
                                      .colors()
                                      .item3,
                                ),
                              ),
                              if (visit.rating != null && visit.rating != 0)
                                Icon(
                                  Rate.values[visit.rating - 1].icon,
                                  color: Rate.values[visit.rating - 1].color,
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
