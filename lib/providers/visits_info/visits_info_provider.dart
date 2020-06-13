import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/repository/response/dto/visit_info.dart';
import 'package:mvp_platform/providers/visits_info/visits_info_data.dart';
import 'package:mvp_platform/repository/rest_api.dart';

class VisitsInfoProvider extends ChangeNotifier {
  final VisitsInfoData _data = VisitsInfoData();

  VisitsInfoProvider._();

  static final _instance = VisitsInfoProvider._();

  factory VisitsInfoProvider() {
    return _instance;
  }

  Future<VisitsInfoProvider> fetchData() async {
    _data.requestStatus = null;
    notifyListeners();
    List<VisitInfo> allVisitsInfo = await _fetchData();
    Client client = allVisitsInfo
        .firstWhere((visitInfo) => visitInfo.client?.id == null)
        .client;
    _data.client = client;
    allVisitsInfo.forEach((visitInfo) => _data.visits.addAll(visitInfo.visits));
    _data.setActiveMonth(DateTime.now());
    _data.requestStatus = RequestStatus.success;
    notifyListeners();
    return this;
  }

  VisitsInfoData get data => _data;

  Future<List<VisitInfo>> _fetchData() async {
    String response = await Service().getVisitsByClient();
    final jsonData = json.decode(response);
    var jsonMap = Map<String, dynamic>.from(jsonData);
    List<VisitInfo> list = jsonMap['result']['visitInfos']
        .map<VisitInfo>((visitInfo) => VisitInfo.fromJson(visitInfo))
        .toList();
    print('Received list: $list');
    return list;
  }
}
