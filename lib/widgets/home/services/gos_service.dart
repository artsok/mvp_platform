import 'package:flutter/material.dart';

import 'package:mvp_platform/models/gos_service.dart' as Model;

class GosService extends StatelessWidget {
  final Model.GosService gosService;

  GosService(this.gosService, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => gosService.callback(context),
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        leading: Icon(gosService.icon),
        title: Text(
          gosService.name,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
