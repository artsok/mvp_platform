import 'package:flutter/cupertino.dart';

class Doctor {
  String profession;
  String name;
  String photoPath;

  Doctor._(this.profession, this.name, this.photoPath);

  factory Doctor({
    @required String profession,
    @required String name,
    String photoPath,
  }) {
    assert(profession != null && profession.isNotEmpty);
    assert(name != null && name.isNotEmpty);
    photoPath = photoPath ?? 'assets/images/doctor.jpg';
    return Doctor._(profession, name, photoPath);
  }

  @override
  bool operator ==(other) =>
      identical(this, other) &&
      other is Doctor &&
      profession == other.profession &&
      name == other.name;

  @override
  int get hashCode => profession.hashCode + name.hashCode;
}
