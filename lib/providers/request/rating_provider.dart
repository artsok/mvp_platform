import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/providers/request/visit_ext_provider.dart';
import 'package:mvp_platform/providers/request/visits_info_provider.dart';
import 'package:mvp_platform/repository/rest_api.dart';

class RatingProvider extends ChangeNotifier {

  VisitsInfoProvider visitsInfo = VisitsInfoProvider();
  VisitExtProvider visitExt = VisitExtProvider();
  RequestStatus requestStatus = RequestStatus.ready;
  String errorMessage;

  RatingProvider._();

  static final _instance = RatingProvider._();

  factory RatingProvider() {
    return _instance;
  }

  void setRating(String id, int rate, {String comment}) {
    requestStatus = RequestStatus.processing;
    notifyListeners();
    Service().setRating(id, rate.toString(), comment: comment).then((result) {
      final jsonData = json.decode(result);
      visitsInfo.fetchData();
      visitExt.fetchData(id);
      requestStatus = RequestStatus.success;
      notifyListeners ();
    }).catchError((e) {
      errorMessage = 'Unknown error';
      if (e is DioError) {
        errorMessage = e.message;
      }
      requestStatus = RequestStatus.error;
      notifyListeners();
    });
  }
}
