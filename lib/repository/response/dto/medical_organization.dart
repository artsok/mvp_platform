import 'package:mvp_platform/repository/response/dto/organization.dart';

class MedicalOrganization extends Organization {
  String ogrn;

  MedicalOrganization.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    ogrn = json['ogrn'] != null ? json['ogrn'] : null;
  }

  String getOgrn() {
    return ogrn;
  }

  void setOgrn(String ogrn) {
    this.ogrn = ogrn;
  }
}
