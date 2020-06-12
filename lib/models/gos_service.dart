import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/typedefs/callbacks.dart';

class GosService {
  final String name;
  NavigatorCallback callback;
  IconData icon;

  GosService._(this.name, this.callback, this.icon);

  factory GosService({
    @required String name,
    @required IconData icon,
    NavigatorCallback callback,
  }) {
    callback = callback ?? (ctx) {};
    icon = icon ?? CupertinoIcons.check_mark_circled;
    return GosService._(name, callback, icon);
  }
}
