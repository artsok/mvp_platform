import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientInfo extends StatelessWidget {
  const PatientInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Пациент',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 4.0),
            const Text(
              'Богатырев Иван Иванович',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
