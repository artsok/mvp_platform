import 'package:mvp_platform/models/enums/response_status.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/repository/response/dto/medical_insurance_organization.dart';
import 'package:mvp_platform/repository/response/dto/visit_info.dart';

class InsuranceInfoData {
  List<MedicalInsuranceOrganization> list;
  ResponseStatus responseStatus;
}
