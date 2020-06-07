import 'package:flutter/material.dart';
import 'package:mvp_platform/models/home/uppertape_item.dart';
import 'package:mvp_platform/widgets/home/uppertape/tape_item.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';

class UpperTape extends StatelessWidget {
  final List<UpperTapeItem> items = [
    new UpperTapeItem(
      name: 'Оплата по квитанции',
      tags: 'УИН, QR код',
      color: '#668095'.colorFromHex(),
      icon: Icons.mail_outline,
    ),
    new UpperTapeItem(
      name: 'Штрафы',
      tags: 'Не найдены',
      color: '#3A72B5'.colorFromHex(),
      icon: Icons.description,
      fading: true,
    ),
    new UpperTapeItem(
      name: 'Налоговая задолжность',
      tags: 'Не найдены',
      color: '#3A72B5'.colorFromHex(),
      icon: Icons.description,
      fading: true,
    ),
    new UpperTapeItem(
      name: 'Судебная задолжность',
      tags: 'Не найдены',
      color: '#3A72B5'.colorFromHex(),
      icon: Icons.email,
      fading: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      width: double.infinity,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return TapeItem(item);
        },
      ),
    );
  }
}
