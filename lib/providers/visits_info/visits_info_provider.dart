import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/response_status.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/repository/response/dto/visit_info.dart';
import 'package:mvp_platform/providers/visits_info/visits_info_data.dart';

class VisitsInfoProvider extends ChangeNotifier {
  final VisitsInfoData _data = VisitsInfoData();

  VisitsInfoProvider._();

  static final _instance = VisitsInfoProvider._();

  factory VisitsInfoProvider() {
    return _instance;
  }

  Future<VisitsInfoProvider> fetchData() async {
    _data.responseStatus = null;
    notifyListeners();
    try {
      List<VisitInfo> allVisitsInfo = await _fetchData();
      Client client = allVisitsInfo
          .firstWhere((visitInfo) => visitInfo.client.id == null)
          .client;
      _data.client = client;
      allVisitsInfo
          .forEach((visitInfo) => _data.visits.addAll(visitInfo.visits));
      _data.responseStatus = ResponseStatus.success;
      notifyListeners();
    } on Exception catch (e, stackTrace) {
      print('Error: $e\n$stackTrace');
    }
    return this;
  }

  VisitsInfoData get data => _data;

  Future<List<VisitInfo>> _fetchData() async {
//    String response =
//        await Service().controlCardVisitInfo().catchError(print, test: (error) {
//      _data.responseStatus = ResponseStatus.error;
//      print('Error: $error');
//      return false;
//    });
    await Future.delayed(Duration(seconds: 2), () {});
    final jsonData = json.decode("""{
  "jsonrpc": "2.0",
  "id": 1,
  "result": [
    {
      "controlCardId": "6836803580823994373",
      "medicalOrganization": {
        "id": "2003",
        "name": "ГБ имени Луначарского",
        "address": "г. Сызрань, пр. Луначарского, 22",
        "phone": "+7(8464) 997-15-62"
      },
      "visits": [
        {
          "id": "6836803580823994373",
          "planDate": "2020-06-03T14:00:00",
          "factDate": null,
          "rating": null,
          "status": "serviceRegistered",
          "doctor": {
            "id": "3003",
            "firstName": "Мария",
            "midName": "Дмитриевна",
            "lastName": "Закруткина",
            "specialty": "Отоларинголог"
          },
          "service": {
            "id": "4001",
            "code": "21421",
            "name": "Прием педиатра",
            "serviceType": "Диспасерное наблюдение"
          }
        }
      ],
      "client": {
        "id": null,
        "firstName": "Богатырев",
        "midName": "Иванович",
        "lastName": "Иван",
        "gender": "MALE",
        "birthDate": "2001-11-01",
        "phone": null,
        "email": null,
        "registrationAddress": null,
        "registrationSince": null,
        "residentialAddress": null,
        "legalRepresentative": null,
        "benefitCategoryCode": null,
        "snils": null,
        "nationality": null,
        "identity": null,
        "policy": {
          "series": null,
          "number": "6351240988099876",
          "territory": "Республика Татарстан",
          "smoCode": null,
          "smoName": null,
          "startDate": null,
          "endDate": null,
          "representative": null
        },
        "birthPlace": null,
        "birthAct": {
          "number": null,
          "date": null
        },
        "parents": null,
        "registration": null,
        "birthCertificate": null
      }
    },
    {
      "controlCardId": "6836803580823994371",
      "medicalOrganization": {
        "id": "2003",
        "name": "ГБ имени Луначарского",
        "address": "г. Сызрань, пр. Луначарского, 22",
        "phone": "+7(8464) 997-15-62"
      },
      "visits": [
        {
          "id": "6836803580823994371",
          "planDate": "2020-06-06T14:00:00",
          "factDate": null,
          "rating": null,
          "status": "serviceRegistered",
          "doctor": null,
          "service": null
        }
      ],
      "client": {
        "id": null,
        "firstName": "Богатырев",
        "midName": "Иванович",
        "lastName": "Иван",
        "gender": "MALE",
        "birthDate": "2001-11-01",
        "phone": null,
        "email": null,
        "registrationAddress": null,
        "registrationSince": null,
        "residentialAddress": null,
        "legalRepresentative": null,
        "benefitCategoryCode": null,
        "snils": null,
        "nationality": null,
        "identity": null,
        "policy": {
          "series": null,
          "number": "6351240988099876",
          "territory": "Республика Татарстан",
          "smoCode": null,
          "smoName": null,
          "startDate": null,
          "endDate": null,
          "representative": null
        },
        "birthPlace": null,
        "birthAct": {
          "number": null,
          "date": null
        },
        "parents": null,
        "registration": null,
        "birthCertificate": null
      }
    }
  ]
}""");
    //final jsonData = json.decode(_body); //Надо делать заглушку, если отвалиться интернет.
    var map = Map<String, dynamic>.from(jsonData);
    List<VisitInfo> list = map['result']
        .map<VisitInfo>((visitInfo) => VisitInfo.fromJson(visitInfo))
        .toList();
    return list;
  }
}
