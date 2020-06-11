import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/response_status.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/repository/response/dto/visit_info.dart';
import 'package:mvp_platform/utils/extensions/datetime_extensions.dart';

class VisitsInfoData with ChangeNotifier {

  Client client;
  List<VisitExt> visits = [];
  List<VisitExt> visitsOfMonth = [];
  ResponseStatus responseStatus;

  DateTime activeMonth;

  void setActiveMonth(DateTime date) {
    if (date.roundToMonth() != activeMonth) {
      activeMonth = date.roundToMonth();
      visitsOfMonth.clear();
      visits.forEach((visit) {
        if (visit.planDate != null &&
            visit.planDate.year == date.year &&
            visit.planDate.month == date.month) {
          visitsOfMonth.add(visit);
        }
      });
      visitsOfMonth.sort((v1, v2) => v1.planDate.compareTo(v2.planDate));
      notifyListeners();
    }
  }

  List<VisitExt> getVisitsOfMonth(DateTime dateTime) {
    List<VisitExt> visitsOfMonth = visits
        .where((visit) =>
            visit.planDate.year == dateTime.year && visit.planDate.month == dateTime.month)
        .toList();
    visitsOfMonth.sort((v1, v2) => v1.planDate.compareTo(v2.planDate));
    return visitsOfMonth;
  }

  Map<DateTime, List<VisitExt>> getDateTimeToVisitsList() {
    Map<DateTime, List<VisitExt>> visitsMap = {};
    visits.forEach((v) {
      if (!visitsMap.containsKey(v.planDate.roundToDay())) {
        visitsMap[v.planDate.roundToDay()] = [];
      }
      visitsMap[v.planDate.roundToDay()].add(v);
    });
    return visitsMap;
  }
}
