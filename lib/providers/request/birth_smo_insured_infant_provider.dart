import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/repository/rest_api.dart';

class BirthSmoProvider extends ChangeNotifier {

  Client client;
  RequestStatus requestStatus;

  BirthSmoProvider._();

  static final _instance = BirthSmoProvider._();

  factory BirthSmoProvider() {
    return _instance;
  }

  Future<BirthSmoProvider> fetchData() async {
    Client client = await _fetchClientData();
    this.client = client;
    requestStatus = RequestStatus.success;
    notifyListeners();
    return this;
  }

  Future<Client> _fetchClientData() async {
    String response = await Service().getInsuredInfant();
    final jsonData = json.decode(response);
    var jsonMap = Map<String, dynamic>.from(jsonData);
    var client = Client.fromJson(jsonMap['result']);
    log('Received client: $client');
    return client;
  }
}
