import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/models/hospital.dart';
import 'package:mvp_platform/repository/response/dto/medical_organization.dart';
import 'package:mvp_platform/repository/rest_api.dart';

class MedicalOrganizationsProvider with ChangeNotifier {
  List<MedicalOrganization> data = [];
  RequestStatus requestStatus;

  MedicalOrganizationsProvider._();

  static final _instance = MedicalOrganizationsProvider._();

  factory MedicalOrganizationsProvider() {
    return _instance;
  }

  Future<MedicalOrganizationsProvider> fetchData() async {
    requestStatus = null;
    notifyListeners();
    List<MedicalOrganization> medicalOrganizations = await _fetchData();
    data = medicalOrganizations;
    requestStatus = RequestStatus.success;
    notifyListeners();
    return this;
  }

  Future<List<MedicalOrganization>> _fetchData() async {
    String response = await Service().getMedicalOrganizations();
    final jsonData = json.decode(response);
    var jsonMap = Map<String, dynamic>.from(jsonData);
    List<MedicalOrganization> list = jsonMap['result']
        .map<MedicalOrganization>(
            (visitInfo) => MedicalOrganization.fromJson(visitInfo))
        .toList();
    list.forEach((mo) => {
          if (mo.code.contains("2"))
            {mo.photoPath = 'assets/medOrganization/2.png'}
          else if (mo.code.contains("4"))
            {mo.photoPath = 'assets/medOrganization/4.png'}
          else
            {
              {mo.photoPath = 'assets/medOrganization/3.png'}
            }
        });
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
