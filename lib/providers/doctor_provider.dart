import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/doctor.dart';

class Doctors with ChangeNotifier {
  static final List<Doctor> doctors = [
    Doctor(
      profession: 'Педиатр',
      name: 'Рыжова С.П. (к. 120)',
    ),
    Doctor(
      profession: 'Кардиолог',
      name: 'Безруков Сергей Валерьевич',
    )
  ];
}
