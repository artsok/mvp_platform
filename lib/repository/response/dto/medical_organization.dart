import 'package:mvp_platform/repository/response/dto/organization.dart';

class MedicalOrganization extends Organization {


  String ogrn;
  String code;
  String photoPath;

  MedicalOrganization.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    ogrn = json['ogrn'] != null ? json['ogrn'] : null;
    code = json['code'] != null ? json['code'] : null;
    photoPath = 'assets/map/1.png';
  }

  String getOgrn() {
    return ogrn;
  }

  void setOgrn(String ogrn) {
    this.ogrn = ogrn;
  }
}
