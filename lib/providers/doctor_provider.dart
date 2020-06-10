import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/doctor.dart';

class Doctors with ChangeNotifier {
  static final List<Doctor> doctors = [
    Doctor(
        profession: 'Врач - кардиолог',
        name: 'Захарова Татьяна Владимировна',
        photoPath: 'assets/images/doctor-2.jpg'),
    Doctor(
        profession: 'Врач ультразвуковой диагностики',
        name: 'Безруков Сергей Валерьевич',
        photoPath: 'assets/images/doctor-bezrukov.jpg')
  ];
}
