import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/response_status.dart';
import 'package:mvp_platform/repository/response/dto/medical_organization.dart';

class MedicalOrganizationsData with ChangeNotifier {

  List<MedicalOrganization> data = [];

  ResponseStatus _responseStatus;

  set responseStatus(ResponseStatus responseStatus) {
    _responseStatus = responseStatus;
    notifyListeners();
  }

  get responseStatus => _responseStatus;
}
