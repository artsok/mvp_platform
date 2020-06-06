import 'package:flutter/material.dart';

extension StringColors on String {
  Color colorFromHex() =>
      Color(int.parse(this.substring(1, 7), radix: 16) + 0xFF000000);
}


Color getGosBlueColor()  {
    return '#2763AA'.colorFromHex();
}
