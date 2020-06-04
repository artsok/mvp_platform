import 'package:flutter/material.dart';
import 'package:mvp_platform/models/home/lowertape_item.dart';
import 'package:mvp_platform/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/home/lowertape/tape_item.dart';

class LowerTape extends StatelessWidget {
  final List<LowerTapeItem> items = [
    new LowerTapeItem(
      name: 'Введите данные авто',
      description: 'Проверяйте и оплачивайте штрафы ГИБДД со скидкой 50%',
      color: '#3A72B5'.colorFromHex(),
      icon: Icons.traffic,
    ),
    new LowerTapeItem(
      name: 'Госпошлина со скидкой 30%',
      description: 'Оплачивайте госпошлины на портале и экономьте. Скидка рассчитывается автоматически.',
      color: '#3A72B5'.colorFromHex(),
      icon: Icons.favorite_border,
    ),
    new LowerTapeItem(
      name: 'Налоговая задолжность',
      description: 'Это нужно затем-то затем-то и затем-то',
      color: '#3A72B5'.colorFromHex(),
      icon: Icons.description,
    ),
    new LowerTapeItem(
      name: 'Судебная задолжность',
      description: 'Это нужно затем-то затем-то и затем-то',
      color: '#3A72B5'.colorFromHex(),
      icon: Icons.email,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      child: ListView.builder(
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
