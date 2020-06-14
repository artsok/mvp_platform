import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mvp_platform/models/gos_notification.dart';
import 'package:mvp_platform/providers/gos_notifications_provider.dart';
import 'package:mvp_platform/providers/request/med_insurance_provider.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/repository/response/dto/medical_organization.dart';
import 'package:mvp_platform/screens/calendar/calendar_screen.dart';
import 'package:mvp_platform/screens/doctor/doctor_info_screen.dart';
import 'package:mvp_platform/screens/home_screen.dart';
import 'package:mvp_platform/utils/extensions/datetime_extensions.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/single_info_item.dart';
import 'package:provider/provider.dart';

class MedicalOrganizationSuccessScreen extends StatelessWidget {
  static const routeName = '/medical-organizatios-success-screen';

  @override
  Widget build(BuildContext context) {
    final MedicalOrganizationSuccessScreenArguments args =
        ModalRoute.of(context).settings.arguments;

    final notifications = Provider.of<GosNotifications>(context);
    final medOrganization = args.medicalOrganization;
    final medInsuranceProvider = MedInsuranceProvider();
    final client = args.client;

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
                'Заявление о прикреплении к медицинской организации № ${medOrganization.ogrn}',
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
                      client.policy?.number ?? '',
                    ),
                    SingleInfoItem(
                      'Фамилия, имя, отчество',
                      client.fullName,
                    ),
                    SingleInfoItem(
                      'Дата рождения',
                      client.birthDate.toDmy(),
                    ),
                    SingleInfoItem(
                      'Адрес проживания',
                      client.parents[0].registrationAddress,
                    ),
                    SingleInfoItem(
                      'Страховая медицинская организация',
                      medInsuranceProvider.selectedOrganization.code ?? 'не выбрана',
                    ),
                    SingleInfoItem(
                      'Прикреплен к',
                      medOrganization.code ?? '',
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
                            medOrganization.photoPath,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: SingleInfoItem(
                        'Адрес пордазделения',
                        medOrganization.address,
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
                          'Городская детская поликлиника № 4 приглашает вашего ребенка на плановый профилактический осмотр, 02.05.2020',
                      callback: (context) => Navigator.of(context)
                          .pushNamed(DoctorInfoScreen.routeName)),
                );
                notifications.addNotification(
                  GosNotification(
                      date: DateTime.now().add(new Duration(minutes: 80)),
                      message:
                          'Ознакомьтесь с вашим календарем посещений плановый профилактических осмотров',
                      callback: (context) => Navigator.of(context)
                          .pushNamed(CalendarScreen.routeName)),
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

class MedicalOrganizationSuccessScreenArguments {
  final Client client;
  final MedicalOrganization medicalOrganization;

  MedicalOrganizationSuccessScreenArguments(
      this.client, this.medicalOrganization);
}
