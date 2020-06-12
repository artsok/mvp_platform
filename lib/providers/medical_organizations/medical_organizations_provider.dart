import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/response_status.dart';
import 'package:mvp_platform/models/hospital.dart';
import 'package:mvp_platform/providers/medical_organizations/medical_organizations_data.dart';
import 'package:mvp_platform/repository/response/dto/medical_organization.dart';
import 'package:mvp_platform/repository/rest_api.dart';

class MedicalOrganizationsProvider with ChangeNotifier {
  final MedicalOrganizationsData _data = MedicalOrganizationsData();

  MedicalOrganizationsProvider._();

  static final _instance = MedicalOrganizationsProvider._();

  factory MedicalOrganizationsProvider() {
    return _instance;
  }

  Future<MedicalOrganizationsProvider> fetchData() async {
    _data.responseStatus = null;
    notifyListeners();
    List<MedicalOrganization> medicalOrganizations = await _fetchData();
    _data.data = medicalOrganizations;
    _data.responseStatus = ResponseStatus.success;
    notifyListeners();
    return this;
  }

  MedicalOrganizationsData get data => _data;

  Future<List<MedicalOrganization>> _fetchData() async {
    String response = await Service().getMedicalOrganizations();
    final jsonData = json.decode(response);
    var jsonMap = Map<String, dynamic>.from(jsonData);
    List<MedicalOrganization> list = jsonMap['result']
        .map<MedicalOrganization>(
            (visitInfo) => MedicalOrganization.fromJson(visitInfo))
        .toList();
    print('Received medical organizations: $list');
    return list;
  }

  static final List<Hospital> hospitals = [
    Hospital(
        'ГБУЗ "Городская детская поликлиника № 2"',
        'г.Калининград, ул.Дзержинского, д.147',
        'assets/map/snezhnaya-22.png',
        '(Выбрана ближайшая к месту жительства детская поликлинника)'),
    Hospital(
      'ГБУЗ "Городская детская поликлиника №4"',
      'г.Калининград, ул.Садовая д.7/13',
      'assets/map/dekabristov-24.png',
    ),
  ];
}
