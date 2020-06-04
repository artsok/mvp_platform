import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/gos_notification.dart';
import 'package:mvp_platform/screens/smo/smo_birth_screen.dart';

class GosNotifications with ChangeNotifier {
  List<GosNotification> _notifications = [
    GosNotification(
      message: 'Присвоен единый номер зарегистрированного лица, Иван И. Б.',
      callback: (context) => Navigator.pushNamed(context, SmoBirthInfoScreen.routeName)
    ),
    GosNotification(
      message: 'Внесена запись акта о рождении ребенка, Иван И. Б.',
    ),
    GosNotification(
      message:
      'Услуга оказана «Получение сведений о состоянии индивидуального лицевого счета»',
    ),
  ];

  List<GosNotification> get items => _notifications;

  void addNotification(GosNotification notification) {
    _notifications.insert(0, notification);
    notifyListeners();
  }
}