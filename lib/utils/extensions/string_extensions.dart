import 'package:flutter/material.dart';
import 'package:mvp_platform/models/enums/gender.dart';
import 'package:mvp_platform/models/enums/visit_status.dart';

extension StringColors on String {
  Color colorFromHex() =>
      Color(int.parse(this.substring(1, 7), radix: 16) + 0xFF000000);

  Gender toGender() => Gender.values
      .firstWhere((gender) => this == gender.toString().split('.')[1]);

  VisitStatus toVisitStatus() => VisitStatus.values
      .firstWhere((status) => this == status.toString().split('.')[1]);
}

Color getGosBlueColor() {
  return '#2763AA'.colorFromHex();
}
