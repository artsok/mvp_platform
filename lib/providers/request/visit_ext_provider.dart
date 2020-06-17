import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/repository/response/dto/visit_info.dart';
import 'package:mvp_platform/repository/rest_api.dart';

class VisitExtProvider extends ChangeNotifier {
  VisitExt visitExt;
  RequestStatus _requestStatus = RequestStatus.ready;
  String errorMessage;

  VisitExtProvider._();

  static final _instance = VisitExtProvider._();

  factory VisitExtProvider() {
    return _instance;
  }

  RequestStatus get requestStatus => _requestStatus;

  set requestStatus(RequestStatus status) {
    _requestStatus = status;
    notifyListeners();
  }

  void fetchData(String visitId) {
    visitExt = null;
    errorMessage = null;
    requestStatus = RequestStatus.processing;
    Service().getVisitExtById(visitId).then((result) {
      final jsonData = json.decode(result);
      var jsonMap = Map<String, dynamic>.from(jsonData);
      VisitExt visitExt = VisitExt.fromJson(jsonMap['result']);
      log('Received visitInfo: $visitExt');
      this.visitExt = visitExt;
      requestStatus = RequestStatus.success;
    }).catchError((error) {
      errorMessage = 'Unknown error';
      if (error is DioError) {
        errorMessage = error.message;
      }
      requestStatus = RequestStatus.error;
    });
  }
}
