import 'package:flutter/material.dart';

class WizardHeader extends StatelessWidget {
  final String iconPath;
  final String title;

  WizardHeader(this.iconPath, this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
              maxHeight: 50.0,
            ),
            child: Image.asset(
              iconPath,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Container(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
