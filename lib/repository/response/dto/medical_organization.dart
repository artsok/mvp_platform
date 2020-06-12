
import 'package:mvp_platform/repository/response/dto/organization.dart';

class MedicalOrganization extends Organization {

  String ogrn;

  MedicalOrganization.fromJson(Map<String, dynamic> json) : super.fromJson(json)  {
    id = json['id'] != null ? json['id'] : null;
    name = json['name'] != null ? json['name'] : null;
    address = json['address'] != null ? json['address'] : null;
    phone = json['phone'] != null ? json['phone'] : null;
  }


  String getName() {
    return name;
  }

  void setName(String name) {
    this.name = name;
  }

  String getAddress() {
    return address;
  }

  void setAddress(String address) {
    this.address = address;
  }

  String getPhone() {
    return phone;
  }

  void setPhone(String phone) {
    this.phone = phone;
  }

  String getId() {
    return id;
  }

  void setId(String id) {
    this.id = id;
  }
}
