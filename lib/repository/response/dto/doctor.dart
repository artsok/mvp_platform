import 'package:mvp_platform/repository/response/dto/person.dart';
import 'package:mvp_platform/utils/assets_utils.dart';

class Doctor extends Person {
  String specialty;

  Doctor() : super() {
    _setPhoto();
  }

  Doctor.all(String id, String firstName, String midName, String lastName,
      String specialty)
      : super.all(id, firstName, midName, lastName) {
    this.specialty = specialty;
    _setPhoto();
  }

  Doctor.withId(String id) : super.withId(id) {
    _setPhoto();
  }

  Doctor.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    specialty = json['specialty'] != null ? json['specialty'] : null;
    _setPhoto();
  }

  @override
  String toString() {
    return 'Doctor{specialty: $specialty}';
  }

  String getSpecialty() {
    return specialty;
  }

  void setSpecialty(String specialty) {
    this.specialty = specialty;
  }

  String _setPhoto() =>
      photoPath = 'assets/images/doctors/${id ?? 'doctor'}.jpg';
}
