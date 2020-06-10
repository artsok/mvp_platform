import 'package:flutter/material.dart';

enum Rate {
  rate1,
  rate2,
  rate3,
  rate4,
  rate5,
}

extension RateExtension on Rate {
  IconData get icon {
    switch (this) {
      case Rate.rate1:
        return Icons.looks_one;
      case Rate.rate2:
        return Icons.looks_two;
      case Rate.rate3:
        return Icons.looks_3;
      case Rate.rate4:
        return Icons.looks_4;
      case Rate.rate5:
        return Icons.looks_5;
      default:
        throw Exception('Unknown rate value');
    }
  }

  Color get color {
    switch (this) {
      case Rate.rate1:
        return Colors.red[500];
      case Rate.rate2:
        return Colors.orange[500];
      case Rate.rate3:
        return Colors.yellow[600];
      case Rate.rate4:
        return Colors.lime[500];
      case Rate.rate5:
        return Colors.green[500];
      default:
        throw Exception('Unknown rate value');
    }
  }

  int get value {
    switch (this) {
      case Rate.rate1:
        return 1;
      case Rate.rate2:
        return 2;
      case Rate.rate3:
        return 3;
      case Rate.rate4:
        return 4;
      case Rate.rate5:
        return 5;
      default:
        throw Exception('Unknown rate value');
    }
  }

  static Rate getRateByValue(int value) => Rate.values[value - 1];
}
