import 'package:flutter/material.dart';

class RatePopupMenu<T> extends PopupMenuEntry<T> {
  const RatePopupMenu({Key key, this.height, this.child}) : super(key: key);

  @override
  final Widget child;

  @override
  final double height;

  @override
  bool get enabled => false;

  @override
  _RatePopupMenuState createState() => new _RatePopupMenuState();

  @override
  bool represents(T value) {
    // TODO: implement represents
    throw UnimplementedError();
  }
}

class _RatePopupMenuState extends State<RatePopupMenu> {
  @override
  Widget build(BuildContext context) => widget.child;
}
