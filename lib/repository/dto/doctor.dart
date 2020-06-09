import 'package:mvp_platform/repository/dto/person.dart';

class Doctor extends Person {
  String specialty;

  String getSpecialty() {
    return specialty;
  }

  void setSpecialty(String specialty) {
    this.specialty = specialty;
  }

  Doctor(
      {String id,
      String firstName,
      String midName,
      String lastName,
      String specialty})
      : super(
            id: id,
            firstName: firstName,
            midName: midName,
            lastName: lastName) {
    this.specialty = specialty;
  }
}
