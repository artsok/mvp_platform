import 'package:mvp_platform/models/enums/response_status.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/repository/response/dto/visit_info.dart';

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
}
