import 'package:flutter/material.dart';
import 'package:mvp_platform/models/doctor.dart';
import 'package:mvp_platform/models/gos_notification.dart';
import 'package:mvp_platform/models/hospital.dart';
import 'package:mvp_platform/providers/gos_notifications_provider.dart';
import 'package:mvp_platform/screens/home_screen.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/single_info_item.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class DoctorSuccessScreen extends StatelessWidget {
  static const routeName = '/doctor-success-screen';

  final int randomNumber = Random().nextInt(9000) + 10000;

  @override
  Widget build(BuildContext context) {
    final DoctorSuccessScreenArguments args =
        ModalRoute.of(context).settings.arguments;

    final notifications = Provider.of<GosNotifications>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Text(
                'Запись на прием к врачу (Заявление № $randomNumber)',
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
                      'Дата и время записи',
                      '16 июня, 2020 г., вторник ${args.time.hour}:${args.time.minute == 0 ? "00" : args.time.minute}',
                    ),
                    SingleInfoItem(
                      'Врач',
                      '${args.doctor.profession}, ${args.doctor.name}',
                    ),
                    SingleInfoItem(
                      'Подразделение',
                      args.hospital.name,
                    ),
                    SingleInfoItem(
                      'Адресс подразделения',
                      args.hospital.address,
                      last: true,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: 270,
                            maxHeight: 230,
                          ),
                          child: Image.asset(
                            args.hospital.imagePath,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
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
                    message: 'Запись на профилактический осмотр оформлена',
                    date: args.time.add(Duration(days: 1)),
                  ),
                );
                Navigator.of(context)
                    .popUntil(ModalRoute.withName(HomeScreen.routeName));
              },
            ),
//            SizedBox(height: 8.0),
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

class DoctorSuccessScreenArguments {
  Hospital hospital;
  Doctor doctor;
  DateTime time;

  DoctorSuccessScreenArguments(this.hospital, this.doctor, this.time);
}
