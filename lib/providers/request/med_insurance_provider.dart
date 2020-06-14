import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/repository/response/dto/medical_insurance_organization.dart';
import 'package:mvp_platform/repository/rest_api.dart';

class MedInsuranceProvider extends ChangeNotifier {
  List<MedicalInsuranceOrganization> data;
  RequestStatus requestStatus = RequestStatus.ready;
  MedicalInsuranceOrganization selectedOrganization;
  String errorMessage;

  MedInsuranceProvider._();

  static final _instance = MedInsuranceProvider._();

  factory MedInsuranceProvider() {
    return _instance;
  }

  MedicalInsuranceOrganization getDefaultOrganization() {
    final organization =
        data.firstWhere((organization) => organization.id == "39002");
    selectedOrganization = organization;
    return organization;
  }

  void fetchData() {
    requestStatus = RequestStatus.processing;
    notifyListeners();
    Service().getMedicalInsuranceOrganizations().then((result) {
      final jsonData = json.decode(result);
      var map = Map<String, dynamic>.from(jsonData);
      data = map["result"]
          .map<MedicalInsuranceOrganization>(
              (i) => MedicalInsuranceOrganization.fromJson(i))
          .toList();
      data = data.where((f) => f.id.startsWith("39")).toList();
      log('Received MedicalInsuranceOrganizations: $MedicalInsuranceOrganization');
      requestStatus = RequestStatus.success;
      notifyListeners();
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
