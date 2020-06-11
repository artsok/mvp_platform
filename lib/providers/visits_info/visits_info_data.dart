import 'package:mvp_platform/models/enums/response_status.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/repository/response/dto/visit_info.dart';
import 'package:mvp_platform/utils/extensions/datetime_extensions.dart';

class VisitsInfoData {
  Client client;
  List<VisitExt> visits = [];
  ResponseStatus responseStatus;

  List<VisitExt> getVisitsOfMonth(int year, int month) {
    List<VisitExt> visitsOfMonth = visits
        .where((visit) =>
            visit.planDate.year == year && visit.planDate.month == month)
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
