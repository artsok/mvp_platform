import 'package:flutter/material.dart';
import 'package:mvp_platform/providers/gos_services_provider.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/common/gos_button.dart';
import 'package:mvp_platform/widgets/home/services/gos_service.dart';

class GosServicesTab extends StatelessWidget {
  static const tabName = 'Услуги';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.separated(
            separatorBuilder: (_, __) => Divider(color: Colors.black),
            itemCount: GosServicesProvider.items.length,
            itemBuilder: (ctx, int i) =>
                GosService(GosServicesProvider.items[i]),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: GosButton(
            'Все услуги',
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
