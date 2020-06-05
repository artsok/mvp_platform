import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/doctor.dart';

class Doctors with ChangeNotifier {
  static final List<Doctor> doctors = [
    Doctor(
      'Педиатр',
      'Рыжова С.П. (к. 120)',
    )
  ];
}
