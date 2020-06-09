import 'package:intl/intl.dart';

import 'int_extensions.dart';

const second = 1000;
const minute = 60 * second;
const hour = 60 * minute;
const day = 24 * hour;
const year = 365 * day;

extension DateTimeExtensions on DateTime {
  String humanizeDifference() => this.humanizeDifferenceWith(DateTime.now());

  String humanizeDifferenceWith(DateTime date) {
    if (date.day - this.day == -1) {
      return 'Завтра';
    }
    if (date.day - this.day == 0) {
      return 'Сегодня';
    }
    if (date.day - this.day == 1) {
      return 'Вчера';
    }
    return DateFormat('dd.MM.yyyy').format(this);
  }

  DateTime roundToDay() => DateTime(this.year, this.month, this.day);
  DateTime roundToMonth() => DateTime(this.year, this.month);

//    if (diff.isIn(-9223372036854775808, -day * 365)) {
//      humanizedDiff = 'более чем через год';
//    } else if (diff.isIn(-day * 365, -hour * 26)) {
//      humanizedDiff = 'через ${TimeUnit.day.plural(-diff ~/ day)}';
//    } else if (diff.isIn(-hour * 26, -hour * 22)) {
//      humanizedDiff = 'через день';
//    } else if (diff.isIn(-hour * 22, -minute * 75)) {
//      humanizedDiff = 'через ${TimeUnit.hour.plural(-diff ~/ hour)}';
//    } else if (diff.isIn(-minute * 75, -minute * 45)) {
//      humanizedDiff = 'через час';
//    }

//    in -MINUTE * 45 until -SECOND * 75 -> 'через ${TimeUnits.MINUTE.plural(-diff / MINUTE)}'
//    in -SECOND * 75 until -SECOND * 45 -> 'через минуту'
//    in -SECOND * 45 until -SECOND -> 'через несколько секунд'
//    in -SECOND until -1 -> 'сейчас'
//    in 0 until SECOND -> 'только что'
//    in SECOND until SECOND * 45 -> 'несколько секунд назад'
//    in SECOND * 45 until SECOND * 75 -> 'минуту назад'
//    in SECOND * 75 until MINUTE * 45 -> '${TimeUnits.MINUTE.plural(diff / MINUTE)} назад'
//    in MINUTE * 45 until MINUTE * 75 -> 'час назад'
//    in MINUTE * 75 until HOUR * 22 -> '${TimeUnits.HOUR.plural(diff / HOUR)} назад'
//    in HOUR * 22 until HOUR * 26 -> 'день назад'
//    in HOUR * 26 until DAY * 360 -> '${TimeUnits.DAY.plural(diff / DAY)} назад'
//    else -> ' более года назад '
}

enum TimeUnit {
  second,
  minute,
  hour,
  day,
  year,
}

extension TimeUnitsExtension on TimeUnit {
  String plural(int amount) {
    if (this == TimeUnit.second) {
      return parse(amount, 'секунд', 'секунду', 'секунды');
    } else if (this == TimeUnit.minute) {
      return parse(amount, 'минут', 'минуту', 'минуты');
    } else if (this == TimeUnit.hour) {
      return parse(amount, 'часов', 'час', 'часа');
    } else if (this == TimeUnit.day) {
      return parse(amount, 'дней', 'день', 'дня');
    } else if (this == TimeUnit.year) {
      return parse(amount, 'лет', 'год', 'года');
    }
  }

  String parse(int amount, String ending1, String ending2, String ending3) {
    String ending = ending1;
    if (amount % 100 == 11) {
      return '$amount $ending';
    }
    int remainder = amount % 10;
    if (remainder == 1) {
      ending = ending2;
    } else if (remainder.isIn(2, 4)) {
      ending = ending3;
    }
    return '$amount $ending';
  }
}
