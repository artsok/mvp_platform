import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/enums/dialog_process_status.dart';
import 'package:mvp_platform/repository/rest_api.dart';

class SelectMedOrganizationProvider extends ChangeNotifier {

  DialogProcessStatus _processStatus = DialogProcessStatus.ready;

  DialogProcessStatus get processStatus => _processStatus;

  Future<void> applyForInsurance(String organizationId) async {
    // @TODO success result: {"jsonrpc":"2.0","id":1,"result":true}
    // @TODO use correct organizationId
    _processStatus = DialogProcessStatus.started;
    notifyListeners();
    String result = await Service().applyForInsurance(await getBirthActId(), /*organizationId*/ "39002");
    await Future.delayed(Duration(seconds: 1), () => true);
    _processStatus = DialogProcessStatus.success;
    notifyListeners();
  }
}
