import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/response_status.dart';
import 'package:mvp_platform/providers/birth_smo/birth_smo_data.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/repository/response/dto/visit_info.dart';
import 'package:mvp_platform/repository/rest_api.dart';
import 'package:mvp_platform/providers/visits_info/visits_info_data.dart';

class BirthSmoProvider extends ChangeNotifier {
  final BirthInfoData _data = BirthInfoData();

  BirthSmoProvider._();

  static final _instance = BirthSmoProvider._();

  factory BirthSmoProvider() {
    return _instance;
  }

  Future<BirthSmoProvider> fetchData() async {
    _data.responseStatus = null;
    notifyListeners();
    try {
      Client client = await _fetchClientData();
      _data.client = client;
      _data.responseStatus = ResponseStatus.success;
      notifyListeners();
    } on Exception catch (e, stackTrace) {
      print('Error: $e\n$stackTrace');
    }
    return this;
  }

  BirthInfoData get data => _data;

  Future<Client> _fetchClientData() async {
    String response = await Service().getInsuredInfant();
    final jsonData = json.decode(response);
    var map = Map<String, dynamic>.from(jsonData);
    var client = Client.fromJson(map["result"]);
    log('Received client: $client');
    return client;
  }
}
