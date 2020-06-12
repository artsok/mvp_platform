import 'package:mvp_platform/repository/response/dto/organization.dart';

class MedicalInsuranceOrganization extends Organization {
  String code;

  MedicalInsuranceOrganization.all(
      String id, String code, String name, String address, String phone)
      : super.all(id, name, address, phone) {
    this.code = code;
  }

  MedicalInsuranceOrganization.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    code = json['code'] != null ? json['code'] : null;
  }

  String getCode() {
    return code;
  }

  void setCode(String code) {
    this.code = code;
  }
}
