import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/typedefs/callbacks.dart';

class GosNotification {
  final String message;
  DateTime date;
  NavigatorCallback callback;
  IconData icon;

  GosNotification._(this.message, this.date, this.callback, this.icon);

  factory GosNotification({
    @required String message,
    DateTime date,
    NavigatorCallback callback,
    IconData icon,
  }) {
    callback = callback ?? (ctx) {};
    icon = icon ?? CupertinoIcons.mail;
    date = date ?? DateTime.now();
    return GosNotification._(message, date, callback, icon);
  }
}
