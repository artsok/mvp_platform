import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/repository/response/dto/visit_info.dart';
import 'package:mvp_platform/repository/rest_api.dart';

class VisitExtProvider extends ChangeNotifier {
  VisitExt visitExt;
  RequestStatus requestStatus = RequestStatus.ready;
  String errorMessage;

  VisitExtProvider._();

  static final _instance = VisitExtProvider._();

  factory VisitExtProvider() {
    return _instance;
  }

  void fetchData(String visitId) {
    requestStatus = RequestStatus.processing;
    notifyListeners();

    Service().getVisitExtById(visitId).then((result) {
      final jsonData = json.decode(result);
      var jsonMap = Map<String, dynamic>.from(jsonData);
      VisitExt visitExt = VisitExt.fromJson(jsonMap['result']);
      log('Received visitInfo: $visitExt');
      this.visitExt = visitExt;
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
}
