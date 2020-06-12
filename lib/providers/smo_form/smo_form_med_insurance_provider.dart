import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/response_status.dart';
import 'package:mvp_platform/providers/birth_smo/birth_smo_data.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/repository/response/dto/medical_insurance_organization.dart';
import 'package:mvp_platform/repository/response/dto/medical_organization.dart';
import 'package:mvp_platform/repository/response/dto/visit_info.dart';
import 'package:mvp_platform/repository/rest_api.dart';
import 'package:mvp_platform/providers/visits_info/visits_info_data.dart';

class MedInsuranceProvider extends ChangeNotifier {
  final BirthInfoData _data = BirthInfoData();

  MedInsuranceProvider._();

  static final _instance = MedInsuranceProvider._();

  factory MedInsuranceProvider() {
    return _instance;
  }

  Future<MedInsuranceProvider> fetchData() async {
    _data.responseStatus = null;
    List<
        MedicalInsuranceOrganization> list = await _fetchMedicalInsuranceData();
    _data.client = client;
    _data.responseStatus = ResponseStatus.success;
    notifyListeners();
    return this;
  }

  BirthInfoData get data => _data;

  Future<List> _fetchMedicalInsuranceData() async {
    String response = await Service.getMedicalInsuranceOrganizations();
    final jsonData = json.decode(response);
    var map = Map<String, dynamic>.from(jsonData);
    List<MedicalInsuranceOrganization> list = map["result"]
        .map<MedicalOrganization>(
            (i) => MedicalInsuranceOrganization.fromJson(i))
        .toList();
    log('Received MedicalOrganizations: $MedicalInsuranceOrganization');
    return list;
  }

}
