import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/hospital.dart';

class Hospitals with ChangeNotifier {
  static final List<Hospital> hospitals = [
    Hospital(
      'ГБУЗ "Городская детская больница № 2"',
      'г.Калининград, ул.Дзержинского, д.147',
      'assets/map/snezhnaya-22.png',
      '(Выбрана ближайшая к месту жительства детская поликлинника)'
    ),
    Hospital(
      'ГБУЗ "Городская детская поликлиника №4"',
      'г.Калининград, ул.Садовая д.7/13',
      'assets/map/dekabristov-24.png',
    ),
  ];
}

//'г.Калининград, ул.Садовая д.7/13',