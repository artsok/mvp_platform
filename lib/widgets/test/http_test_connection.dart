import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp_platform/repository/response/dto/visit_info.dart';
import 'package:mvp_platform/repository/rest_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TestHttpConnectionForm extends StatefulWidget {
  final String url;

  TestHttpConnectionForm({String url}) : url = url;

  @override
  State<StatefulWidget> createState() => TestHttpState();
}

class TestHttpState extends State<TestHttpConnectionForm> {
  String _url, _body;

  @override
  void initState() {
    _url = widget.url;
    super.initState();
  }

  _sendRequestPost() async {
    _body = await Service().controlCardVisitInfo();
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
    List<VisitInfo> list = map["result"].map<VisitInfo>((i) => VisitInfo.fromJson(i)).toList();
    setState(() {}); //reBuildWidget
  }

  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
            child: Column(
      children: <Widget>[
        Container(
            child: Text('API url',
                style: TextStyle(fontSize: 20.0, color: Colors.blue)),
            padding: EdgeInsets.all(10.0)),
        RaisedButton(
            child: Text('Send request POST'), onPressed: _sendRequestPost),
        SizedBox(height: 20.0),
        Text('Response body',
            style: TextStyle(fontSize: 20.0, color: Colors.blue)),
        Text(_body == null ? '' : _body),
      ],
    )));
  } //buil
}
