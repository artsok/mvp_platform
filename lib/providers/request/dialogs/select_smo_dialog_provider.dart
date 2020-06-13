import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/repository/rest_api.dart';

class SelectSmoDialogProvider extends ChangeNotifier {
  RequestStatus _processStatus = RequestStatus.ready;

  RequestStatus get processStatus => _processStatus;

  Future<void> applyForInsurance(String organizationId) async {
    // @TODO success result: {"jsonrpc":"2.0","id":1,"result":true}
    _processStatus = RequestStatus.processing;
    notifyListeners();
    String result = await Service()
        .applyForInsurance(await getBirthActId(), organizationId);
    await Future.delayed(Duration(seconds: 1), () => true);
    _processStatus = RequestStatus.success;
    notifyListeners();
  }
}
