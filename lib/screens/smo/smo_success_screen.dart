import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mvp_platform/models/child.dart';
import 'package:mvp_platform/models/gos_notification.dart';
import 'package:mvp_platform/models/insurance_company.dart';
import 'package:mvp_platform/providers/gos_notifications_provider.dart';
import 'package:mvp_platform/screens/home_screen.dart';
import 'package:mvp_platform/screens/medical_organization/medical_organization_info_screen.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/single_info_item.dart';
import 'package:provider/provider.dart';

class SmoSuccessScreen extends StatelessWidget {
  static const routeName = '/smo-success-screen';

  final int randomNumber = new Random().nextInt(9000) + 10000;

  @override
  Widget build(BuildContext context) {
    final SmoSuccessScreenArguments args =
        ModalRoute.of(context).settings.arguments;

    final notifications = Provider.of<GosNotifications>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Text(
                'Заявление о получении полиса ОМС для ребёнка № $randomNumber принято',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
            Container(
              width: 350,
              child: Card(
                elevation: 5.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SingleInfoItem('ФИО ребёнка', args.child.fullname),
                    SingleInfoItem('Дата рождения', args.child.birthDate),
                    SingleInfoItem('СНИЛС', args.child.snils),
                    SingleInfoItem('Адрес проживания', args.child.address),
                    SingleInfoItem('СМО', args.insuranceCompany.name),
                    SingleInfoItem(
                      'Прикреплен к',
                      'ГБУЗ г. Рязань "Городская поликлиника № 17 ДЗМ"',
                      last: true,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.0),
            GosFlatButton(
              backgroundColor: '#2763AA'.colorFromHex(),
              textColor: Colors.white,
              text: 'Готово',
              width: 350.0,
              onPressed: () {
                notifications.addNotification(GosNotification(
                  message: 'Оформлен выбор страховой медицинской организации',
                ));
                notifications.addNotification(
                  GosNotification(
                    message: 'Желаете выбрать другое медицинское учреждение',
                    callback: (ctx) => Navigator.of(ctx)
                        .pushReplacementNamed(MedicalOrganizationInfoScreen.routeName),
                  ),
                );
                Navigator.of(context)
                    .pushReplacementNamed(HomeScreen.routeName);
              },
            ),
            SizedBox(height: 8.0),
            GosFlatButton(
              text: 'Отменить',
              backgroundColor: Colors.white,
              onPressed: () => Navigator.of(context).pop(),
            ),
            GosFlatButton(
                text: 'Прикрепить ребенка к другому учреждению',
                fontSize: 14,
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(MedicalOrganizationInfoScreen.routeName);
                  notifications.addNotification(GosNotification(
                    message: 'Оформлен выбор страховой медицинской организации',
                  ));
                }),
          ],
        ),
      ),
    );
  }
}

class SmoSuccessScreenArguments {
  final Child child;
  final InsuranceCompany insuranceCompany;

  SmoSuccessScreenArguments(this.child, this.insuranceCompany);
}
