import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

enum VisitStatus {
  serviceCompleted,
  serviceNotified,
  serviceRegistered,
}

extension VisitStatusExtension on VisitStatus {
  String translate() {
    switch (this) {
      case VisitStatus.serviceCompleted:
        return 'Состоялось';
      case VisitStatus.serviceNotified:
        return 'Запись подтверждена';
      case VisitStatus.serviceRegistered:
        return 'Записаться на прием';
      default:
        throw Exception('Unknown VisitStatus');
    }
  }

  /// text, background, action button color
  Tuple3<Color, Color, Color> colors() {
    switch (this) {
      case VisitStatus.serviceCompleted:
        return Tuple3(Colors.black54, Colors.grey[300], Colors.black54);
      case VisitStatus.serviceNotified:
        return Tuple3(Colors.green[900], Colors.green[100], Colors.green[900]);
      case VisitStatus.serviceRegistered:
        return Tuple3(
            Colors.red[800], Colors.deepOrange[100], Colors.blueAccent);
      default:
        throw Exception('Unknown VisitStatus');
    }
  }
}
