import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvp_platform/models/gos_notification.dart'
    as GosNotificationModel;
import 'package:mvp_platform/utils/extensions/datetime_extensions.dart';

class GosNotification extends StatelessWidget {
  final GosNotificationModel.GosNotification notification;

  const GosNotification(this.notification, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => notification.callback(context),
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        leading: Icon(notification.icon),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              notification.date.humanizeDifference(),
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            Text(
              DateFormat('HH:mm').format(notification.date),
              style: TextStyle(fontSize: 12, color: Colors.black54),
            )
          ],
        ),
        title: Text(
          notification.message,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
