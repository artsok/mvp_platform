import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

enum EventState {
  complete,
  canceled,
  approved,
  planned,
}

extension EventStateExtension on EventState {
  String translate() {
    if (this == EventState.canceled) {
      return 'Отменено';
    }
    if (this == EventState.complete) {
      return 'Состоялось';
    }
    if (this == EventState.approved) {
      return 'Запись подтверждена';
    }
    if (this == EventState.planned) {
      return 'Записаться на прием';
    }
    throw Exception('Unknown EventState');
  }

  /// text, background, action button color
  Tuple3<Color, Color, Color> colors() {
    if (this == EventState.approved) {
      return Tuple3(Colors.green[900], Colors.green[100], Colors.green[900]);
    }
    if (this == EventState.canceled || this == EventState.planned) {
      return Tuple3(Colors.red[800], Colors.deepOrange[100], Colors.blueAccent);
    }
    return Tuple3(Colors.black54, Colors.grey[300], Colors.black54);
  }
}
