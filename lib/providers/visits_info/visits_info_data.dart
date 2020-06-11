import 'package:mvp_platform/models/enums/response_status.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/repository/response/dto/visit_info.dart';
import 'package:mvp_platform/utils/extensions/datetime_extensions.dart';

class VisitsInfoData {
  Client client;
  List<VisitExt> visits = [];
  ResponseStatus responseStatus;

  List<VisitExt> getItemsOfMonth(int year, int month) {
    return visits
        .where((visit) =>
            visit.planDate.year == year && visit.planDate.month == month)
        .toList();
  }

  Map<DateTime, List<VisitExt>> getDateTimeToVisitsList() {
    Map<DateTime, List<VisitExt>> visitsMap = {};
    visits.forEach((v) {
      if (!visitsMap.containsKey(v.planDate.roundToMonth())) {
        visitsMap[v.planDate.roundToMonth()] = [];
      }
      visitsMap[v.planDate.roundToMonth()].add(v);
    });
    return visitsMap;
  }
}
