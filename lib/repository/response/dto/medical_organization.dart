import 'package:mvp_platform/repository/response/dto/organization.dart';

class MedicalOrganization extends Organization {

  String ogrn;
  String photoPath;

  MedicalOrganization.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    ogrn = json['ogrn'] != null ? json['ogrn'] : null;
    photoPath = 'assets/map/snezhnaya-22.png';
  }

  String getOgrn() {
    return ogrn;
  }

  void setOgrn(String ogrn) {
    this.ogrn = ogrn;
  }
}
