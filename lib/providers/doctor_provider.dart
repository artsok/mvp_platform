import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/doctor.dart';

class Doctors with ChangeNotifier {
  static final List<Doctor> doctors = [
    Doctor(
        profession: 'Педиатр',
        name: 'Рыжова С.П. (к. 120)',
        photoPath: 'assets/images/doctor-2.jpg'),
    Doctor(
        profession: 'Кардиолог',
        name: 'Безруков Сергей Валерьевич',
        photoPath: 'assets/images/doctor-bezrukov.jpg')
  ];
}
