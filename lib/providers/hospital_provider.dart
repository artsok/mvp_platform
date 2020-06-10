import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/hospital.dart';

class Hospitals with ChangeNotifier {
  static final List<Hospital> hospitals = [
    Hospital(
      'ГБУЗ "Городская детская поликлиника №4"',
      'г.Калининград, ул.Садовая д.7/13',
      'assets/map/dekabristov-24.png',
    ),
    Hospital(
      'ГБУЗ г.Калининград "Городская детская поликлиника №4"',
      'г.Калининград, ул.Дзержинского, д.147',
      'assets/map/snezhnaya-22.png',
    ),
  ];
}
