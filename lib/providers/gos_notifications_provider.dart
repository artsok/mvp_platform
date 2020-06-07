import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/gos_notification.dart';
import 'package:mvp_platform/screens/smo/smo_birth_screen.dart';

class GosNotifications with ChangeNotifier {
  List<GosNotification> _notifications = [
    GosNotification(
      message:
          'Государственная регистрация регистрации рождения ребенка (Богатырев Иван Иванович).',
      callback: (ctx) =>
          Navigator.of(ctx).pushNamed(SmoBirthInfoScreen.routeName),
    ),
//    GosNotification(
//      message: 'Внесена запись акта о рождении ребенка, Иван И. Б.',
//    ),
    GosNotification(
      message:
          'Услуга оказана «Получение сведений о состоянии индивидуального лицевого счета»',
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    GosNotification(
      message: 'Test notification',
      date: DateTime.now().subtract(Duration(days: 23)),
    ),
  ];

  List<GosNotification> get items => _notifications;

  void addNotification(GosNotification notification) {
    _notifications.insert(0, notification);
    notifyListeners();
  }
}
