import 'package:flutter/material.dart';
import 'package:mvp_platform/screens/doctor/doctor_info_screen.dart';
import 'package:mvp_platform/screens/events/events_screen.dart';
import 'package:mvp_platform/screens/hospital/hospital_info_screen.dart';
import 'package:mvp_platform/screens/smo/smo_info_screen.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
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
                contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                leading: Icon(Icons.business),
                title: const Text(
                  'Выбор медицинского учреждения',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                onTap: () =>
                    Navigator.pushNamed(context, HospitalInfoScreen.routeName),
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                leading: Icon(Icons.healing),
                title: const Text('Запись к врачу',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                onTap: () =>
                    Navigator.pushNamed(context, DoctorInfoScreen.routeName),
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                leading: Icon(Icons.description),
                title: const Text('Выбор СМО',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                onTap: () =>
                    Navigator.pushNamed(context, SmoInfoScreen.routeName),
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                leading: Icon(Icons.calendar_today),
                title: const Text('Календарь',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                onTap: () =>
                    Navigator.pushNamed(context, EventsScreen.routeName),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: GosButton(
            'Все услуги',
            size: 12,
            width: 170,
            icon: Icons.arrow_forward_ios,
            iconColor: getGosBlueColor(),
          ),
        )
      ],
    );
  }
}
