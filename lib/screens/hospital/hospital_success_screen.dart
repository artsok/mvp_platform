import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mvp_platform/models/gos_notification.dart';
import 'package:mvp_platform/models/hospital.dart';
import 'package:mvp_platform/providers/children_provider.dart';
import 'package:mvp_platform/providers/gos_notifications_provider.dart';
import 'package:mvp_platform/screens/doctor/doctor_info_screen.dart';
import 'package:mvp_platform/screens/home_screen.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/single_info_item.dart';
import 'package:provider/provider.dart';

class HospitalSuccessScreen extends StatelessWidget {
  static const routeName = '/hospital-success-screen';

  final int randomNumber = new Random().nextInt(9000) + 10000;

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
            SizedBox(
              height: 56,
            ),
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
                    SingleInfoItem(
                      'Полис ОМС',
                      Children.children[0].oms,
                    ),
                    SingleInfoItem(
                      'Фамилия, имя, отчество',
                      Children.children[0].fullname,
                    ),
                    SingleInfoItem(
                      'Дата рождения',
                      Children.children[0].birthDate,
                    ),
                    SingleInfoItem(
                      'Адрес проживания',
                      Children.children[0].address,
                    ),
                    SingleInfoItem(
                      'Страховая медицинская организация',
                      "АО «СОГАЗ Мед» СОГАЗ МЕД",
                    ),
                    SingleInfoItem(
                      'Прикреплен к',
                      args.hospital.name,
                    ),
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
                    date: DateTime.now().add(new Duration(minutes: 1)),
                    message:
                        'Полис ОМС для ребенка Богатырев Иван Иванович № 6351240828000236 выпущен',
                  ),
                );
                notifications.addNotification(
                  GosNotification(
                    date: DateTime.now().add(new Duration(minutes: 4)),
                    message:
                    'Богатырев Иван Иванович застрахован в страховой медицинской организации АО «СОГАЗ Мед» СОГАЗ МЕД',
                  ),
                );
                notifications.addNotification(
                  GosNotification(
                    date: DateTime.now().add(new Duration(minutes: 5)),
                    message:
                        'Богатырев Иван Иванович прикреплен к медицинской организации ГБУЗ г.Калининград "Городская детская больница № 4"',
                  ),
                );
                notifications.addNotification(
                  GosNotification(
                      date: DateTime.now().add(new Duration(minutes: 10)),
                      message:
                          'Городская детская больница № 4 приглашает вашего ребенка на плановый профилактический осмотр, 02.05.2020',
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
