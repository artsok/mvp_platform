import 'package:flutter/material.dart';
import 'package:mvp_platform/models/gos_notification.dart';
import 'package:mvp_platform/models/hospital.dart';
import 'package:mvp_platform/providers/children_provider.dart';
import 'package:mvp_platform/providers/gos_notifications_provider.dart';
import 'package:mvp_platform/screens/doctor/doctor_info_screen.dart';
import 'package:mvp_platform/screens/doctor/doctor_success_screen.dart';
import 'package:mvp_platform/screens/home_screen.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/screens/smo/smo_success_screen.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/single_info_item.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class HospitalSuccessScreen extends StatelessWidget {
  static const routeName = '/hospital-success-screen';
  int randomNumber = new Random().nextInt(9000) + 10000;

  @override
  Widget build(BuildContext context) {
    final HospitalSuccessScreenArguments args =
        ModalRoute.of(context).settings.arguments;

    final notifications = Provider.of<GosNotifications>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 56,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Text(
                'Заявление о прикреплении к медицинской организации № $randomNumber',
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
                    SingleInfoItem('Свидетельство о рождении',
                        Children.children[0].birthCertificateId),
                    SingleInfoItem('Фамилия, имя, отчество',
                        Children.children[0].fullname),
                    SingleInfoItem(
                        'Дата рождения', Children.children[0].birthDate),
                    SingleInfoItem('СНИЛС', Children.children[0].snils),
                    SingleInfoItem('Страховая медицинская организация', "АО «СОГАЗ Мед» СОГАЗ МЕД"),
                    SingleInfoItem(
                        'Адрес проживания', Children.children[0].address),
                    SingleInfoItem('Прикреплен к', args.hospital.name),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: 400,
                            maxHeight: 400,
                          ),
                          child: Image.asset(
                            args.hospital.imagePath,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: SingleInfoItem(
                        'Адрес пордазделения',
                        'г.Калининград, ул.Садовая д.7/13',
                        last: true,
                      ),
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
                        'Полис ОМС для ребенка (Богатырев Иван Иванович) № 6351240828000236 выпущен',
                  ),
                );
                notifications.addNotification(
                  GosNotification(
                    message:
                    'Богатырев Иван Иванович прикреплен к медицинской организации ГБУЗ КАЛИНИНГРАДСКОЙ ОБЛАСТИ «ГОРОДСКАЯ БОЛЬНИЦА №2»',
                  ),
                );
                notifications.addNotification(
                  GosNotification(
                      message:
                          'Приглашение Вашего ребенка на плановый профилактический осмотр, 02.05.2020.',
                      callback: (context) => Navigator.of(context)
                          .pushNamed(DoctorInfoScreen.routeName)),
                );
                Navigator.of(context)
                    .popUntil(ModalRoute.withName(HomeScreen.routeName));
              },
            ),
            SizedBox(height: 36.0),
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

class HospitalSuccessScreenArguments {
  final Hospital hospital;

  HospitalSuccessScreenArguments(this.hospital);
}
