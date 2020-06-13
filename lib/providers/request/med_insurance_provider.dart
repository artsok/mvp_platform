import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/repository/response/dto/medical_insurance_organization.dart';
import 'package:mvp_platform/repository/rest_api.dart';

class MedInsuranceProvider extends ChangeNotifier {
  List<MedicalInsuranceOrganization> data = [];
  RequestStatus requestStatus;

  MedInsuranceProvider._();

  static final _instance = MedInsuranceProvider._();

  factory MedInsuranceProvider() {
    return _instance;
  }

  MedicalInsuranceOrganization getDefaultOrganization() =>
      data.firstWhere((organization) => organization.id == "39002");

  Future<MedInsuranceProvider> fetchData() async {
    requestStatus = null;
    notifyListeners();
    List<MedicalInsuranceOrganization> organizations =
        await _fetchMedicalInsuranceData();
    organizations = organizations.where((f) => f.id.startsWith("39")).toList();

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
