import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/insurance_company.dart';

class InsuranceCompanies with ChangeNotifier {
  static final List<InsuranceCompany> insuranceCompanies = [
    InsuranceCompany(
      'АО "Страховая компания "Альфа-Страхование"',
      'г.Калининград, Россия',
    ),
    InsuranceCompany(
      'АО «СОГАЗ Мед» СОГАЗ МЕД',
      'г.Калининград, Россия',
    ),
    InsuranceCompany(
      'АО "Страховая компания "Сбербанк-Страхование"',
      'г.Калининград, Россия',
    ),
  ];
}
