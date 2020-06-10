import 'package:flutter/material.dart';

class RatePopupMenuButton extends StatelessWidget {
  final VoidCallback callback;
  final IconData icon;
  final Color color;

  const RatePopupMenuButton({
    @required this.callback,
    @required this.icon,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
