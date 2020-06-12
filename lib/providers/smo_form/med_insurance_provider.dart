import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/response_status.dart';
import 'package:mvp_platform/repository/response/dto/medical_insurance_organization.dart';
import 'package:mvp_platform/repository/rest_api.dart';

class MedInsuranceProvider extends ChangeNotifier {

  List<MedicalInsuranceOrganization> data = [];
  ResponseStatus responseStatus;

  MedInsuranceProvider._();

  static final _instance = MedInsuranceProvider._();

  factory MedInsuranceProvider() {
    return _instance;
  }

  Future<MedInsuranceProvider> fetchData() async {
    responseStatus = null;
    notifyListeners();
    List<MedicalInsuranceOrganization> organizations =
        await _fetchMedicalInsuranceData();
    data = organizations;
    responseStatus = ResponseStatus.success;
    notifyListeners();
    return this;
  }

  Future<List> _fetchMedicalInsuranceData() async {
    String response = await Service().getMedicalInsuranceOrganizations();
    final jsonData = json.decode(response);
    var map = Map<String, dynamic>.from(jsonData);
    List<MedicalInsuranceOrganization> insurances = map["result"]
        .map<MedicalInsuranceOrganization>(
            (i) => MedicalInsuranceOrganization.fromJson(i))
        .toList();
    log('Received MedicalInsuranceOrganizations: $MedicalInsuranceOrganization');
    return insurances;
  }
}
