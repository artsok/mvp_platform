import 'package:mvp_platform/repository/response/dto/person.dart';

class Doctor extends Person {
  String specialty;

  Doctor() : super();

  String getSpecialty() {
    return specialty;
  }

  void setSpecialty(String specialty) {
    this.specialty = specialty;
  }

  Doctor.all(String id, String firstName, String midName, String lastName,
      String specialty)
      : super.all(id, firstName, midName, lastName) {
    this.specialty = specialty;
  }

  Doctor.withId(String id) : super.withId(id);

  Doctor.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    specialty = json['specialty'] != null ? json['specialty'] : null;
  }

  @override
  String toString() {
    return 'Doctor{specialty: $specialty}';
  }
}
