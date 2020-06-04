import 'package:flutter/material.dart';

class GosButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final double size;
  final double width;
  final Color color;
  final Color iconColor;
  VoidCallback onPressed = () {};

  GosButton(
    this.text, {
    this.width = 180,
    this.size = 16.0,
    this.color,
    this.icon,
    this.iconColor,
    this.onPressed,
    Key key,
  })  : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: FlatButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text.toUpperCase(),
              style: TextStyle(
                  fontSize: size,
                  color: color ?? Theme.of(context).primaryColor),
            ),
            if (icon != null) SizedBox(width: size / 8),
            if (icon != null)
              Icon(
                icon,
                color: iconColor ?? Theme.of(context).primaryColor,
                size: size,
              ),
          ],
        ),
      ),
    );
  }
}
