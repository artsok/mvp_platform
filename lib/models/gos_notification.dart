import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/typedefs/navigator_callback.dart';

class GosNotification {
  final String message;
  final IconData icon = CupertinoIcons.mail;
  final DateTime date = DateTime.now();
  NavigatorCallback callback = (ctx) {};

  GosNotification({
    @required this.message,
    this.callback,
  });
}