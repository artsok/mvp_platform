import 'package:flutter/material.dart';
import 'package:mvp_platform/screens/hospital/hospital_info_screen.dart';
import 'package:mvp_platform/screens/smo/smo_info_screen.dart';
import 'package:mvp_platform/widgets/common/gos_button.dart';

class Services extends StatelessWidget {
  static const tabName = 'Услуги';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.healing),
                title: const Text('Выбор медицинского учреждения'),
                onTap: () =>
                    Navigator.pushNamed(context, HospitalInfoScreen.routeName),
              ),
              ListTile(
                leading: Icon(Icons.healing),
                title: const Text('Запись к врачу'),
              ),
              ListTile(
                leading: Icon(Icons.description),
                title: const Text('Выбор СМО'),
                onTap: () =>
                    Navigator.pushNamed(context, SmoInfoScreen.routeName),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: GosButton(
            'Все услуги',
            width: 180,
            icon: Icons.arrow_forward_ios,
          ),
        )
      ],
    );
  }
}