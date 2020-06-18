import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/repository/response/dto/visit_info.dart';
import 'package:mvp_platform/repository/rest_api.dart';
import 'package:mvp_platform/utils/extensions/datetime_extensions.dart';

class VisitsInfoProvider extends ChangeNotifier {
  Client client;
  List<VisitExt> visits = [];
  List<VisitExt> visitsOfMonth = [];
  RequestStatus requestStatus = RequestStatus.ready;
  DateTime activeMonth;
  String errorMessage;

  VisitsInfoProvider._();

  static final _instance = VisitsInfoProvider._();

  factory VisitsInfoProvider() {
    return _instance;
  }

  void fetchData() {
    requestStatus = RequestStatus.processing;
    notifyListeners();

    Service().getVisitsByClient().then((result) {
      final jsonData = json.decode(result);
      var jsonMap = Map<String, dynamic>.from(jsonData);
      List<VisitInfo> allVisitsInfo = jsonMap['result']['visitInfos']
          .map<VisitInfo>((visitInfo) => VisitInfo.fromJson(visitInfo))
          .toList();
      visits.clear();
      allVisitsInfo.forEach((visitInfo) => visits.addAll(visitInfo.visits));
      if (activeMonth == null) {
        setActiveMonth(DateTime.now());
      } else {
        setActiveMonth(activeMonth);
      }
      log('Received visits: $visits');
      Client client = allVisitsInfo
          .firstWhere((visitInfo) => visitInfo.client?.id == null,
              orElse: () => null)
          ?.client;
      this.client = client;
      log('Received client: $client');
      requestStatus = RequestStatus.success;
      notifyListeners();
    }).catchError((error) {
      errorMessage = 'Unknown error';
      if (error is DioError) {
        errorMessage = error.message;
      }
      requestStatus = RequestStatus.error;
      notifyListeners();
    });
  }

  void setActiveMonth(DateTime date) {
    activeMonth = date.roundToMonth();
    visitsOfMonth.clear();
    visits.forEach((visit) {
      if (visit.planDate != null &&
          visit.planDate.year == date.year &&
          visit.planDate.month == date.month) {
        visitsOfMonth.add(visit);
      }
    });
    visitsOfMonth.sort((v1, v2) {
      int compareResult = v1.planDate.compareTo(v2.planDate);
      if (compareResult == 0) {
        if (v1.rating == null && v2.rating == null) {
          compareResult = 0;
        } else if (v1.rating != null && v2.rating == null) {
          compareResult = -1;
        } else if (v1.rating == null && v2.rating != null) {
          compareResult = 1;
        } else {
          compareResult = v2.rating.compareTo(v1.rating);
        }
      }
      return compareResult;
    });
    notifyListeners();
  }

  List<VisitExt> getVisitsOfMonth(DateTime dateTime) {
    List<VisitExt> visitsOfMonth = visits
        .where((visit) =>
            visit.planDate.year == dateTime.year &&
            visit.planDate.month == dateTime.month)
        .toList();
    visitsOfMonth.sort((v1, v2) {
      int compareResult = v1.planDate.compareTo(v2.planDate);
      if (compareResult == 0) {
        if (v1.rating == null && v2.rating == null) {
          compareResult = 0;
        } else if (v1.rating != null && v2.rating == null) {
          compareResult = -1;
        } else if (v1.rating == null && v2.rating != null) {
          compareResult = 1;
        } else {
          compareResult = v2.rating.compareTo(v1.rating);
        }
      }
      return compareResult;
    });
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
