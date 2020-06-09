import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:mvp_platform/repository/dto/person.dart';
import 'package:mvp_platform/utils/app_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class URLS {
  static const String BASE_URL =
      'http://ds-ingressgateway-unsec.foms-2.apps.ocp-public.sbercloud.ru';

  static const String PATH = 'foms-client';
}

Future<String> loadJson(String jsonFileName) async {
  return await rootBundle.loadString('assets/json/${jsonFileName}');
}

class Service {
  Service._privateConstructor() {}

  static final Service _instance = Service._privateConstructor();

  factory Service() {
    return _instance;
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('clientId');
  }

  Future<String> getHttp() async {
    //loadJson("createcontrolcard.json").then((value) => print(value));

    var dio = new Dio();
    final List<int> certClient =
        (await rootBundle.load('assets/cert/client.example.crt'))
            .buffer
            .asInt8List();
    final List<int> keyClient =
        (await rootBundle.load('assets/cert/client.example.key'))
            .buffer
            .asInt8List();
    final List<int> rootCA =
        (await rootBundle.load('assets/cert/rootCA.crt')).buffer.asInt8List();

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      SecurityContext sc = new SecurityContext(withTrustedRoots: true);
      sc.setTrustedCertificatesBytes(rootCA);
      sc.useCertificateChainBytes(certClient);
      sc.usePrivateKeyBytes(keyClient);
      HttpClient httpClient = new HttpClient(context: sc);
      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
      return httpClient;
    };

    try {
      Response response = await dio.post(
          "${URLS.BASE_URL}/${URLS.PATH}/createControlCard",
          data: (await loadJson("createcontrolcard.json")));
    } catch (e) {
      return "No Internet connection";
    }
  }

  static Future<dynamic> getVisitsByClient(String clientId) async {
    var dio = new Dio();
    final List<int> certClient =
        (await rootBundle.load('assets/cert/client.example.crt'))
            .buffer
            .asInt8List();
    final List<int> keyClient =
        (await rootBundle.load('assets/cert/client.example.key'))
            .buffer
            .asInt8List();
    final List<int> rootCA =
        (await rootBundle.load('assets/cert/rootCA.crt')).buffer.asInt8List();

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      SecurityContext sc = new SecurityContext(withTrustedRoots: true);
      sc.setTrustedCertificatesBytes(rootCA);
      sc.useCertificateChainBytes(certClient);
      sc.usePrivateKeyBytes(keyClient);
      HttpClient httpClient = new HttpClient(context: sc);
      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
      return httpClient;
    };

    try {
      Response response = await dio.post(
          "${URLS.BASE_URL}/${URLS.PATH}/controlCardVisitInfo",
          data: (await loadJson("createcontrolcard.json")));
      return response;
    } catch (e) {
      return "No Internet connection";
    }
  }

  static Future<String> get() async {
    var body;
    try {
      final response = await http.post('https://json.flutter.su/echo');
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
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
