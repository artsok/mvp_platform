import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/repository/rest_api.dart';

class BirthSmoProvider extends ChangeNotifier {
  Client client;
  RequestStatus requestStatus = RequestStatus.ready;
  String errorMessage;

  BirthSmoProvider._();

  static final _instance = BirthSmoProvider._();

  factory BirthSmoProvider() {
    return _instance;
  }

  void fetchData() {
    requestStatus = RequestStatus.processing;
    notifyListeners();
    Service().getInsuredInfant().then((result) {
      final jsonData = json.decode(result);
      var jsonMap = Map<String, dynamic>.from(jsonData);
      var client = Client.fromJson(jsonMap['result']);
      this.client = client;
      requestStatus = RequestStatus.success;
      log('Received client: $client');
      notifyListeners();
    }).catchError((error) {
      if (error is DioError) {
        errorMessage = error.message;
      }
      requestStatus = RequestStatus.error;
      errorMessage = 'Unknown error';
      notifyListeners();
    });
  }
}
