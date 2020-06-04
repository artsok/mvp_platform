import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/hospital.dart';

class Hospitals with ChangeNotifier {
  static final List<Hospital> hospitals = [
    Hospital(
      'ГБУЗ г. Москвы "Городская поликлиника № 107 ДЗМ"',
      'г.Москва, ул.Декабристов, д.24',
    ),
  ];
}
