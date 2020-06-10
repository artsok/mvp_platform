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
//    final jsonData = json.decode("""{
//  "jsonrpc": "2.0",
//  "id": 1,
//  "result": [
//    {
//      "controlCardId": "6836680778900504577",
//      "medicalOrganization": {
//        "id": null,
//        "name": "555",
//        "address": null,
//        "phone": null
//      },
//      "visits": [
//        {
//          "id": "6836680778900504579",
//          "planDate": "2020-06-03T14:00:00",
//          "factDate": null,
//          "service": null,
//          "rating": null,
//          "status": "serviceRegistered",
//          "doctor": null
//        },
//        {
//          "id": "6836680778900504581",
//          "planDate": "2020-06-03T14:00:00",
//          "factDate": null,
//          "service": "узи сердца ребёнка",
//          "rating": null,
//          "status": "serviceRegistered",
//          "doctor": {
//            "id": "1",
//            "firstName": null,
//            "midName": null,
//            "lastName": null,
//            "specialty": null
//          }
//        }
//      ]
//    },
//    {
//      "controlCardId": "6836439427508273153",
//      "medicalOrganization": {
//        "id": null,
//        "name": "6835965767305920520",
//        "address": null,
//        "phone": null
//      },
//      "visits": [
//        {
//          "id": "6836439427508273155",
//          "planDate": "2020-06-03T14:00:00",
//          "factDate": null,
//          "service": "узи сердца ребёнка",
//          "rating": null,
//          "status": "serviceRegistered",
//          "doctor": {
//            "id": "2",
//            "firstName": null,
//            "midName": null,
//            "lastName": null,
//            "specialty": null
//          }
//        },
//        {
//          "id": "6836439427508273157",
//          "planDate": "2020-06-06T14:00:00",
//          "factDate": null,
//          "service": null,
//          "rating": null,
//          "status": "serviceRegistered",
//          "doctor": null
//        }
//      ]
//    },
//    {
//      "controlCardId": "6836439483342848001",
//      "medicalOrganization": {
//        "id": null,
//        "name": "6835965767305920520",
//        "address": null,
//        "phone": null
//      },
//      "visits": [
//        {
//          "id": "6836439483342848003",
//          "planDate": "2020-06-06T14:00:00",
//          "factDate": null,
//          "service": null,
//          "rating": null,
//          "status": "serviceRegistered",
//          "doctor": null
//        },
//        {
//          "id": "6836439483342848005",
//          "planDate": "2020-06-03T14:00:00",
//          "factDate": null,
//          "service": "узи сердца ребёнка",
//          "rating": null,
//          "status": "serviceRegistered",
//          "doctor": {
//            "id": "2",
//            "firstName": null,
//            "midName": null,
//            "lastName": null,
//            "specialty": null
//          }
//        }
//      ]
//    },
//    {
//      "controlCardId": "6836680830440112129",
//      "medicalOrganization": {
//        "id": null,
//        "name": "555",
//        "address": null,
//        "phone": null
//      },
//      "visits": [
//        {
//          "id": "6836680830440112131",
//          "planDate": "2020-06-03T14:00:00",
//          "factDate": null,
//          "service": "узи сердца ребёнка",
//          "rating": null,
//          "status": "serviceRegistered",
//          "doctor": {
//            "id": "1",
//            "firstName": null,
//            "midName": null,
//            "lastName": null,
//            "specialty": null
//          }
//        },
//        {
//          "id": "6836680830440112133",
//          "planDate": "2020-06-03T14:00:00",
//          "factDate": null,
//          "service": null,
//          "rating": null,
//          "status": "serviceRegistered",
//          "doctor": null
//        }
//      ]
//    },
//    {
//      "controlCardId": "6836680830440112137",
//      "medicalOrganization": {
//        "id": null,
//        "name": "555",
//        "address": null,
//        "phone": null
//      },
//      "visits": [
//        {
//          "id": "6836680830440112139",
//          "planDate": "2020-06-03T14:00:00",
//          "factDate": null,
//          "service": "узи сердца ребёнка",
//          "rating": null,
//          "status": "serviceRegistered",
//          "doctor": {
//            "id": "1",
//            "firstName": null,
//            "midName": null,
//            "lastName": null,
//            "specialty": null
//          }
//        },
//        {
//          "id": "6836680830440112141",
//          "planDate": "2020-06-03T14:00:00",
//          "factDate": null,
//          "service": null,
//          "rating": null,
//          "status": "serviceRegistered",
//          "doctor": null
//        }
//      ]
//    },
//    {
//      "controlCardId": "6836680834735079425",
//      "medicalOrganization": {
//        "id": null,
//        "name": "555",
//        "address": null,
//        "phone": null
//      },
//      "visits": [
//        {
//          "id": "6836680834735079427",
//          "planDate": "2020-06-03T14:00:00",
//          "factDate": null,
//          "service": "узи сердца ребёнка",
//          "rating": null,
//          "status": "serviceRegistered",
//          "doctor": {
//            "id": "1",
//            "firstName": null,
//            "midName": null,
//            "lastName": null,
//            "specialty": null
//          }
//        },
//        {
//          "id": "6836680834735079429",
//          "planDate": "2020-06-03T14:00:00",
//          "factDate": null,
//          "service": null,
//          "rating": null,
//          "status": "serviceRegistered",
//          "doctor": null
//        }
//      ]
//    }
//  ]
//}""");
    final jsonData = json.decode(_body); //Надо делать заглушку, если отвалиться интернет.
    var map = Map<String, dynamic>.from(jsonData);
    List<VisitInfo> list = map["result"].map<VisitInfo>((i) => VisitInfo.fromJson(i)).toList();
    print(list);
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
