import 'dart:async' show Future;
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:mvp_platform/repository/request/request_dto.dart';
import 'package:mvp_platform/utils/app_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class URLS {
  static const String BASE_URL =
      'http://ds-ingressgateway-unsec.foms-2.apps.ocp-public.sbercloud.ru';
  static const String PATH = 'foms-client';
}

Future<String> getClientId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('clientId');
}

Future<String> getBirthActId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('birthActId');
}

Future<String> loadJson(String jsonFileName) async {
  return await rootBundle.loadString('assets/json/${jsonFileName}');
}

class Service {
  Service._();

  static final Service _instance = Service._();

  factory Service() {
    return _instance;
  }

  ///Оценка посещения. Id - visits.id (берем из метода getVisitsByClient), rating on 1-5
  void setRating(String id, String rating) async {
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
    var requestDto = RequestDto(
        method: "setRating",
        id: 1,
        params: Params.setRating(id: id, rating: rating));
    try {
      Response response = await dio.post(
          "${URLS.BASE_URL}/${URLS.PATH}/changeControlCardVisit",
          data: requestDto.toJsonSetRating());
      log('${response.data}');
    } catch (e) {
      log('No Internet connection(setRating)');
    }
  }

  //Отмена посещения (TODO!)
  void cancelVisit(String id) async {
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
    var requestDto = RequestDto(
        method: "setRating", id: 1, params: Params.setRating(id: id));
    try {
      Response response = await dio.post(
          "${URLS.BASE_URL}/${URLS.PATH}/changeControlCardVisit",
          data: requestDto.toJsonSetRating());
      log('${response.data}');
    } catch (e) {
      log('No Internet connection(setRating)');
    }
  }

  ///Получение информации о посещениях клиента
  Future<dynamic> getVisitsByClient() async {
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
    var requestDto = RequestDto(
        method: "getVisitsByClient",
        id: 1,
        params: Params.withClientIdAndPlanDate(clientId: await getClientId()));
    try {
      Response response = await dio.post(
          "${URLS.BASE_URL}/${URLS.PATH}/controlCardVisitInfo",
          data: requestDto.toJsonGetVisitsByClient());
      return response.data;
    } catch (e) {
      return "No Internet connection (getVisitsByClient)";
    }
  }

  ///Получение сведений о новорожденном для показа в мобильном приложении
  Future<dynamic> getInsuredInfant() async {
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
    var requestDto = RequestDto(
        method: "getInsuredInfant",
        id: 1,
        params: Params.withBirthActId(birthActId: await getBirthActId()));
    try {
      Response response = await dio.post(
          "${URLS.BASE_URL}/${URLS.PATH}/clientService",
          data: requestDto.toJsonInsuredInfant());
      return response.data;
    } catch (e) {
      return "No Internet connection (getInsuredInfant)";
    }
  }

  //Получение информации о мед. организациях
  Future<dynamic> getMedicalOrganizations() async {
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
    var requestDto =
        RequestDto(method: "getMedicalOrganizations", id: 1, params: Params());
    try {
      Response response = await dio.post(
          "${URLS.BASE_URL}/${URLS.PATH}/infoService",
          data: requestDto.toJsonGetMedicalOrganizations());
      return response.data;
    } catch (e) {
      return "No Internet connection (getInsuredInfant)";
    }
  }

  ///Изменение информации о посещении (planDate в формате 2020-06-08T14:00:00)
  Future<dynamic> changeVisit(String id, String planDate, int doctorId,
      int serviceId, String status) async {
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
    var requestDto = RequestDto(
        method: "changeVisit",
        id: 1,
        params: Params.changeVisit(
            changeControlCardVisitParams: ChangeControlCardVisitParams(
                id: id,
                planDate: planDate,
                doctorId: doctorId,
                serviceId: serviceId,
                status: status)));
    try {
      Response response = await dio.post(
          "${URLS.BASE_URL}/${URLS.PATH}/changeControlCardVisit",
          data: requestDto.toJsonChangeVisit());
      return response.data;
    } catch (e) {
      return "No Internet connection (changeControlCardVisit)";
    }
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
