import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/repository/response/dto/medical_insurance_organization.dart';
import 'package:mvp_platform/repository/rest_api.dart';

class MedInsuranceProvider extends ChangeNotifier {
  List<MedicalInsuranceOrganization> data = [];
  RequestStatus requestStatus = RequestStatus.ready;
  MedicalInsuranceOrganization selectedOrganization;

  MedInsuranceProvider._();

  static final _instance = MedInsuranceProvider._();

  factory MedInsuranceProvider() {
    return _instance;
  }

  MedicalInsuranceOrganization getDefaultOrganization() {
    final organization = data.firstWhere((organization) => organization.id == "39002");
    selectedOrganization = organization;
    return organization;
  }

  Future<MedInsuranceProvider> fetchData() async {
    requestStatus = RequestStatus.processing;
    notifyListeners();
    List<MedicalInsuranceOrganization> organizations =
        await _fetchMedicalInsuranceData();
    data = organizations;
    requestStatus = RequestStatus.success;
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
