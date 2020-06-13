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

  Future<BirthSmoProvider> fetchData() async {
    requestStatus = RequestStatus.processing;
    notifyListeners();
    try {
      final response = await Service().getInsuredInfant();
      final jsonData = json.decode(response);
      var jsonMap = Map<String, dynamic>.from(jsonData);
      var client = Client.fromJson(jsonMap['result']);
      this.client = client;
      requestStatus = RequestStatus.success;
      log('Received client: $client');
      notifyListeners();
    } on DioError catch (error) {
      requestStatus = RequestStatus.error;
      errorMessage = error.message;
      notifyListeners();
    }
    return this;
  }
}
