import 'dart:async' show Future;
import 'dart:core';
import 'dart:developer';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mvp_platform/repository/request/request_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  ///Прикрепление ребёнка к МО
  Future<dynamic> changeMedicalOrganization(
      String policyNumber, String medicalOrganizationCode) async {
    log("Прикрепление ребёнка к МО");
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
        method: "changeMedicalOrganization",
        id: 1,
        params: Params.changeMedicalOrganization(
            assignment: Assignment(
                policyNumber: policyNumber,
                medicalOrganizationCode: medicalOrganizationCode)));
    try {
      Response response = await dio.post(
          "${URLS.BASE_URL}/${URLS.PATH}/clientService",
          data: requestDto.toJsonChangeMedicalOrganization());
      log('${response.data}');
      return response.data;
    } catch (e) {
      log('No Internet connection(changeMedicalOrganization)');
      return 'Unknown error';
    }
  }

  ///Прикрепление ребёнка к СМО
  Future<dynamic> applyForInsurance(String birthActId, String smoId) async {
    log("Прикрепление ребёнка к СМО");
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
        method: "applyForInsurance",
        id: 1,
        params: Params.applyForInsurance(
            insuranceApplicationDetails: InsuranceApplicationDetails(
                birthActId: birthActId, smoId: smoId)));
    try {
      Response response = await dio.post(
          "${URLS.BASE_URL}/${URLS.PATH}/clientService",
          data: requestDto.toJsonApplyForInsurance());
      log('Результат прикрепления к СМО: ${response.data}');
      return response.data;
    } catch (e) {
      log('No Internet connection(applyForInsurance)');
      return "Неизвестная ошибка прикрепления к СМО";
    }
  }

  ///Оценка посещения. Id - visits.id (берем из метода getVisitsByClient), rating on 1-5
  Future<dynamic> setRating(String id, String rating, {String comment}) async {
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
        params: Params.setRating(id: id, rating: rating, ratingComment: comment));
    Response response = await dio.post(
        "${URLS.BASE_URL}/${URLS.PATH}/changeControlCardVisit",
        data: requestDto.toJsonSetRating());
    log('Set rating response: ${response.data}');
    return response.data;
  }

  //Отмена посещения
  Future<dynamic> cancelVisit(String visitId) async {
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
        params: Params.getVisitsParams(
            getVisitsParams: GetVisitsParams(
                clientId: await getClientId(),
                startDate: "2020-05-01T14:00:00",
                endDate: "2020-06-30T14:00:00")));
    Response response = await dio.post(
        "${URLS.BASE_URL}/${URLS.PATH}/controlCardVisitInfo",
        data: requestDto.toJsonGetVisitsByClient());
    log("${response.data}");
    return response.data;
  }

  ///Получение информации о посещении по id
  Future<dynamic> getVisitExtById(String visitId) async {
    log("Получение информации о посещении клиента");
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

    final requestDto = RequestDto(
      method: "getVisit",
      id: 1,
      params: Params.getVisitExtParams(visitId),
    );

    Map<String, dynamic> finalDto = requestDto.toJsonGetVisitExtParams();
    Response response = await dio.post(
      "${URLS.BASE_URL}/${URLS.PATH}/controlCardVisitInfo",
      data: finalDto,
    );
    log("${response.data}");
    return response.data;
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
    Response response = await dio.post(
        "${URLS.BASE_URL}/${URLS.PATH}/clientService",
        data: requestDto.toJsonInsuredInfant());
    log("${response.data}");
    return response.data;
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
    var requestDto = RequestDto(
        method: "getMedicalOrganizations",
        id: 1,
        params: Params.withFilter(filter: Filter.all(null, null, null)));
    try {
      Response response = await dio.post(
          "${URLS.BASE_URL}/${URLS.PATH}/infoService",
          data: requestDto.toJsonWithFilter());
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
    var requestDto = RequestDto(
        method: "getMedicalInsuranceOrganizations",
        id: 1,
        params: Params.withFilter(filter: Filter.all(null, null, null)));
    Response response = await dio.post(
        "${URLS.BASE_URL}/${URLS.PATH}/infoService",
        data: requestDto.toJsonWithFilter());
    log("${response.data}");
    return response.data;
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
