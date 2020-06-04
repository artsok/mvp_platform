import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/insurance_company.dart';

class InsuranceCompanies with ChangeNotifier {
  static final List<InsuranceCompany> insuranceCompanies = [
    InsuranceCompany(
      'АО "Страховая компания "СОГАЗ-Мед"',
      'г.Калининград, Россия',
    ),
    InsuranceCompany(
      'АО "Страховая компания "О-Мед"',
      'г.Омск, Россия',
    ),
  ];
}
