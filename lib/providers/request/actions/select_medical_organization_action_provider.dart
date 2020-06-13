import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/repository/rest_api.dart';

class SelectMedOrganizationActionProvider extends ChangeNotifier {

  RequestStatus _processStatus = RequestStatus.ready;

  RequestStatus get processStatus => _processStatus;

  Future<void> selectMedicalOrganization(String omsId, String organizationId) async {
    log('Changing medical organization [$organizationId] for oms [$omsId]');
    _processStatus = RequestStatus.processing;
    notifyListeners();
    String result = await Service().changeMedicalOrganization(omsId, organizationId);
    await Future.delayed(Duration(seconds: 1), () => true);
    _processStatus = RequestStatus.success;
    notifyListeners();
  }
}
