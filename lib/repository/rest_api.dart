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
    log("Оценка посещения");
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

  //Отмена посещения
  void cancelVisit(String visitId) async {
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
        method: "cancel", id: 1, params: Params.cancelVisit(visitId: visitId));
    try {
      Response response = await dio.post(
          "${URLS.BASE_URL}/${URLS.PATH}/changeControlCardVisit",
          data: requestDto.toJsonCancelVisit());
      log('${response.data}');
    } catch (e) {
      log('No Internet connection(changeControlCardVisit - Cancel Visit)');
    }
  }

  ///Получение информации о посещениях клиента
  Future<dynamic> getVisitsByClient() async {
    log("Получение информации о посещениях клиента");
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
        params: Params.getVisitParams(
            getVisitParams: GetVisitParams(
                clientId: await getClientId(),
                startDate: "2020-05-01T14:00:00",
                endDate: "2020-06-30T14:00:00")));
    try {
      Response response = await dio.post(
          "${URLS.BASE_URL}/${URLS.PATH}/controlCardVisitInfo",
          data: requestDto.toJsonGetVisitsByClient());
      log("${response.data}");
      return response.data;
    } catch (e) {
      return "No Internet connection (getVisitsByClient)";
    }
  }

  ///Получение сведений о новорожденном для показа в мобильном приложении
  Future<dynamic> getInsuredInfant() async {
    log("Получение сведений о новорожденном");
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
      log("${response.data}");
      return response.data;
    } catch (e) {
      return "No Internet connection (getInsuredInfant)";
    }
  }

  //Получение информации о мед. организациях
  Future<dynamic> getMedicalOrganizations() async {
    log("Получение информации о мед. организациях");
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
      log("${response.data}");
      return response.data;
    } catch (e) {
      return "No Internet connection (getInsuredInfant)";
    }
  }

  //Получение списка страховых компаний
  Future<dynamic> getMedicalInsuranceOrganizations() async {
    log("Получение списка страховых компаний");
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
    RequestDto(method: "getMedicalInsuranceOrganizations", id: 1, params: Params());
    try {
      Response response = await dio.post(
          "${URLS.BASE_URL}/${URLS.PATH}/clientService",
          data: requestDto.toJsonGetMedicalOrganizations());
      log("${response.data}");
      return response.data;
    } catch (e) {
      return "No Internet connection (getMedicalInsuranceOrganizations)";
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

}
