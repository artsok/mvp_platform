import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/hospital.dart';

class Hospitals with ChangeNotifier {
  static final List<Hospital> hospitals = [
    Hospital(
      'ГБУЗ г. Москвы "Городская поликлиника № 107 ДЗМ (Декабристов)"',
      'г.Москва, ул.Декабристов, д.24',
      'assets/map/dekabristov-24.png',
    ),
    Hospital(
      'ГБУЗ г. Москвы "Городская поликлиника № 107 ДЗМ" (Снежная)',
      'г.Москва, ул.Снежная, 22',
      'assets/map/snezhnaya-22.png',
    ),
  ];
}
