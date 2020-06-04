import 'package:flutter/material.dart';
import 'package:mvp_platform/extensions/string_extensions.dart';
import 'package:mvp_platform/models/gos_notification.dart';
import 'package:mvp_platform/models/hospital.dart';
import 'package:mvp_platform/providers/children_provider.dart';
import 'package:mvp_platform/providers/gos_notifications_provider.dart';
import 'package:mvp_platform/screens/home_screen.dart';
import 'package:mvp_platform/screens/smo/smo_success_screen.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/single_info_item.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class SuccessfulHospitalScreen extends StatelessWidget {
  static const routeName = '/successfull-med-screen';
  int randomNumber = new Random().nextInt(9000) + 10000;

  @override
  Widget build(BuildContext context) {
    final SuccessfulHospitalScreenArguments args =
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
                'Заявление о прикреплении к медицинской организации № $randomNumber',
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
                    SingleInfoItem('Свидетельство о рождении', Children.children[0].birthCertificateId),
                    SingleInfoItem('Фамилия, имя, отчество', Children.children[0].fullname),
                    SingleInfoItem('Дата рождения', Children.children[0].birthDate),
                    SingleInfoItem('СНИЛС', Children.children[0].snils),
                    SingleInfoItem('Адрес проживания', Children.children[0].address),
                    SingleInfoItem('Полис ОМС', '5152 0108 8793 0032'),
                    SingleInfoItem('Прикреплен к', args.hospital.name),
                    SingleInfoItem('Адрес пордазделения', 'г.Калининград, ул.Дзержинского, д.147', last: true,
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
                notifications.addNotification(
                  GosNotification(
                    message:
                        'Выбрано новое медицинское учреждение для дальнейшего обслуживания',
                  ),
                );
                Navigator.of(context)
                    .popUntil(ModalRoute.withName(HomeScreen.routeName));
              },
            ),
            SizedBox(height: 8.0),
//            GosFlatButton(
//              text: 'Отменить',
//              backgroundColor: Colors.white,
//              onPressed: () => Navigator.of(context).pop(),
//            ),
          ],
        ),
      ),
    );
  }
}

class SuccessfulHospitalScreenArguments {
  final Hospital hospital;

  SuccessfulHospitalScreenArguments(this.hospital);
}
