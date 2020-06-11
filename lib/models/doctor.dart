import 'package:flutter/cupertino.dart';

class Doctor with ChangeNotifier {
  String profession;
  String name;
  String photoPath;
  double _rating;

  Doctor._(this.profession, this.name, this.photoPath, this._rating);

  factory Doctor({
    @required String profession,
    @required String name,
    String photoPath,
    int rating,
  }) {
    assert(profession != null && profession.isNotEmpty);
    assert(name != null && name.isNotEmpty);
    photoPath = photoPath ?? 'assets/images/doctor.jpg';
    return Doctor._(profession, name, photoPath, 0.0);
  }

  @override
  bool operator ==(other) =>
      identical(this, other) &&
      other is Doctor &&
      profession == other.profession &&
      name == other.name;

  @override
  int get hashCode => profession.hashCode + name.hashCode;


  double get rating => _rating;

  set rating(double value) {
    _rating = value.toDouble();
    notifyListeners();
  }
}
