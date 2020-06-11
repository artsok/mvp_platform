import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/gos_notification.dart';
import 'package:mvp_platform/screens/smo/smo_birth_screen.dart';

class GosNotifications with ChangeNotifier {
  List<GosNotification> _notifications = [
    GosNotification(
      message: 'Богатырев Иван Иванович застрахован в системе ОМС',
      callback: (ctx) =>
          Navigator.of(ctx).pushNamed(SmoBirthInfoScreen.routeName),
    ),
    GosNotification(
      message:
          'Состоялась государственная регистрация рождения ребенка (Богатырев Иван Иванович)',
      date: DateTime.now().subtract(new Duration(minutes: 360)),
      callback: (ctx) =>
          Navigator.of(ctx).pushNamed(SmoBirthInfoScreen.routeName),
    )
//    GosNotification(
//      message:
//          'Услуга оказана «Получение сведений о состоянии индивидуального лицевого счета»',
//      date: DateTime.now().subtract(Duration(days: 3)),
//    ),
  ];

  List<GosNotification> get items => _notifications;

  void addNotification(GosNotification notification) {
    _notifications.insert(0, notification);
    notifyListeners();
  }
}
