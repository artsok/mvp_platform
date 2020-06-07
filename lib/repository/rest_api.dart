import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:mvp_platform/utils/app_exceptions.dart';

class URLS {
  static const String BASE_URL =
      'http://ds-ingressgateway-unsec.foms-2.apps.ocp-public.sbercloud.ru';
}

Future<String> loadJson(String jsonFileName) async {
  return await rootBundle.loadString('assets/json/${jsonFileName}');
}

class Service {

  static Future<dynamic> createControlCard() async {
    var responseJson;
    String body = await loadJson("createcontrolcard.json");
    try {
      final response = await http.post(
          '${URLS.BASE_URL}/foms-client/createControlCard',
          body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  static Future<String> get() async {
    var body;
    try {
      final response = await http.post(
          'https://json.flutter.su/echo');
      body = response.body;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return body;
  }
  static dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response
                .statusCode}');
    }
  }
}
