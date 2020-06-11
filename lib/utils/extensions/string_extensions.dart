import 'package:flutter/material.dart';
import 'package:mvp_platform/models/enums/gender.dart';

extension StringColors on String {
  Color colorFromHex() =>
      Color(int.parse(this.substring(1, 7), radix: 16) + 0xFF000000);

  Gender toGender() =>
      Gender.values.firstWhere((gender) => this == gender.toString());
}


Color getGosBlueColor() {
  return '#2763AA'.colorFromHex();
}
