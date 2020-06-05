import 'package:flutter/material.dart';
import 'package:mvp_platform/models/child.dart';
import 'package:mvp_platform/models/gos_notification.dart';
import 'package:mvp_platform/models/insurance_company.dart';
import 'package:mvp_platform/providers/gos_notifications_provider.dart';
import 'package:mvp_platform/screens/home_screen.dart';
import 'package:mvp_platform/screens/hospital/hospital_info_screen.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/single_info_item.dart';
import 'package:provider/provider.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';

class SmoSuccessScreen extends StatelessWidget {
  static const routeName = '/smo-success-screen';

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
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: const Text(
                'Договор успешно заключен!',
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
                    SingleInfoItem('Полис ОМС', '5152 0108 8793 0032'),
                    SingleInfoItem('Ребенок', args.child.fullname),
                    SingleInfoItem(
                        'Регион прикрепления', 'Рязанская область, Россия'),
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
                        .pushReplacementNamed(HospitalInfoScreen.routeName),
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
              onPressed: () => Navigator.of(context)
                  .popUntil(ModalRoute.withName(HomeScreen.routeName)),
            ),
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
