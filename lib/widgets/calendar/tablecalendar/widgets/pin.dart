import 'package:flutter/material.dart';

class Pin extends StatelessWidget {
  final VoidCallback callback = () {};

  Pin({VoidCallback callback, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          color: Colors.lightBlue[800],
          width: 50,
          height: 18,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _Row(),
              _Row(),
              _Row(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.0),
      color: Colors.white,
      height: 3.0,
      width: 32.0,
    );
  }
}
