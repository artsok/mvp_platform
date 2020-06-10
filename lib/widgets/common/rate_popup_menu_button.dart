import 'package:flutter/material.dart';
import 'package:mvp_platform/models/enums/rate.dart';

class RatePopupMenuButton extends StatelessWidget {
  final VoidCallback callback;
  final Rate rate;

  const RatePopupMenuButton({
    @required this.callback,
    @required this.rate,
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
          color: rate.color
        ),
      ),
    );
  }
}
