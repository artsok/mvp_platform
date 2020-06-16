import 'package:flutter/material.dart';
import 'package:mvp_platform/models/enums/rate.dart';

class RatePopupMenuButton extends StatelessWidget {
  final VoidCallback callback;
  final Rate rate;
  final double size;

  const RatePopupMenuButton({
    @required this.callback,
    @required this.rate,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(rate.value);
        callback();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Icon(
          rate.icon,
          color: rate.color,
          size: size,
        ),
      ),
    );
  }
}
