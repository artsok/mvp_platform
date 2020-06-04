import 'package:flutter/material.dart';

class SingleInfoItem extends StatelessWidget {
  final String hint;
  final String value;
  final bool last;

  SingleInfoItem(
    this.hint,
    this.value, {
    this.last = false,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: last
          ? const EdgeInsets.all(8.0)
          : EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                hint,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black45,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
