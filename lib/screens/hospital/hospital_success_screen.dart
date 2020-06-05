import 'package:flutter/material.dart';
import 'package:mvp_platform/models/gos_notification.dart';
import 'package:mvp_platform/models/hospital.dart';
import 'package:mvp_platform/providers/gos_notifications_provider.dart';
import 'package:mvp_platform/screens/doctor/doctor_success_screen.dart';
import 'package:mvp_platform/screens/home_screen.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/widgets/common/single_info_item.dart';
import 'package:provider/provider.dart';

class HospitalSuccessScreen extends StatelessWidget {
  static const routeName = '/hospital-success-screen';

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
              child: const Text(
                'Заявка успешно оформлена',
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
                    SingleInfoItem(
                        'Регион прикрепления', 'Московская область, Россия'),
                    SingleInfoItem(
                        'Выбранное мед.учреждение', args.hospital.name),
                    SingleInfoItem(
                      'Адрес пордазделения',
                      'г. Москва, ул.Пестеля, д.6А',
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
            GosFlatButton(
              text: 'Отменить',
              backgroundColor: Colors.white,
              onPressed: () => Navigator.of(context).pop(),
            ),
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
