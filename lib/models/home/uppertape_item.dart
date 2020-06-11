import 'package:flutter/material.dart';
import 'package:mvp_platform/typedefs/callbacks.dart';

class UpperTapeItem {
  String name;
  String tags;
  Color color;
  IconData icon;
  bool fading;
  NavigatorCallback navigatorCallback;

  UpperTapeItem({this.name, this.tags, this.color, this.icon, this.navigatorCallback, this.fading = false});
}
