import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GosCupertinoLoadingIndicator extends StatelessWidget {
  const GosCupertinoLoadingIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: const CupertinoActivityIndicator(radius: 10.0),
    );
  }
}
