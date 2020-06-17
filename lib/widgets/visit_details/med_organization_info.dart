import 'package:flutter/material.dart';
import 'package:mvp_platform/models/hospital.dart';

class MedOrganizationInfo extends StatelessWidget {
  // @TODO hardcode
  final hospital = Hospital(
    'ГБУЗ "Городская детская поликлиника №4"',
    'г.Калининград, ул.Садовая д.7/13',
    'assets/map/dekabristov-24.png',
  );

  MedOrganizationInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Лечебное учреждение',
            style: TextStyle(color: Colors.black54),
          ),
          SizedBox(height: 4.0),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      hospital.name,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      hospital.address,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.location_on,
                color: Colors.blue[700],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
