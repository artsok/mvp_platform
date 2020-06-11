import 'package:flutter/material.dart';

class GosFlatButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final double height;
  final EdgeInsetsGeometry margin;
  final double fontSize;
  double width = -1.0;
  Color textColor = Colors.white;
  Color backgroundColor;

  GosFlatButton({
    @required this.text,
    this.onPressed,
    this.height,
    this.margin,
    this.fontSize = 16,
    this.width,
    this.textColor,
    this.backgroundColor,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (backgroundColor == null) {
      backgroundColor = Theme.of(context).primaryColor;
      textColor = Colors.white;
    }
    if (textColor == null) {
      textColor = Theme.of(context).primaryColor;
    }
    Widget button = FlatButton(
      color: backgroundColor,
      onPressed: onPressed,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.white,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
        ),
      ),
    );

    if (width == -1.0) {
      button = Wrap(
        children: <Widget>[button],
      );
    }

    return Container(
      margin: margin,
      color: backgroundColor,
      width: width == -1.0 ? null : width,
      height: height,
      child: button,
    );
  }
}
