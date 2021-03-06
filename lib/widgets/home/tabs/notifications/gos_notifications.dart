import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/providers/gos_notifications_provider.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/common/gos_button.dart';
import 'package:mvp_platform/widgets/home/tabs/notifications/gos_notification.dart';
import 'package:provider/provider.dart';

class GosNotificationsTab extends StatefulWidget {
  static const tabName = 'Уведомления';

  @override
  _GosNotificationsTabState createState() => _GosNotificationsTabState();
}

class _GosNotificationsTabState extends State<GosNotificationsTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<GosNotifications>(
          builder: (_, notifications, __) => Expanded(
            child: ListView.separated(

              separatorBuilder: (_, __) => Divider(color: Colors.black),
              itemCount: notifications.items.length,
              itemBuilder: (ctx, i) => GosNotification(notifications.items[i]),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: GosButton(
            'все уведомления',
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
