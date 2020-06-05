import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/typedefs/callbacks.dart';

class GosNotification {
  final String message;
  final IconData icon = CupertinoIcons.mail;
  DateTime date;
  NavigatorCallback callback = (ctx) {};

  GosNotification({
    @required this.message,
    DateTime date,
    this.callback,
  }) : date = date ?? DateTime.now();
}
