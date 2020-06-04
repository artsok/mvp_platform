import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/hospital.dart';

class Hospitals with ChangeNotifier {
  static final List<Hospital> hospitals = [
    Hospital(
      'ГБУЗ г.Калининград "Городская поликлиника №7"',
      'г.Калининград, ул.Декабристов, д.24',
    ),
    Hospital(
      'ГБУЗ г.Калининград "Городская больница № 2"',
      'г.Калининград, ул.Дзержинского, д.147',
    ),
  ];
}
