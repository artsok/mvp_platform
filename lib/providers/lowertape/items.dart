import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/models/home/lowertape_item.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';

class LowerTapeItems with ChangeNotifier {
  final List<LowerTapeItem> _items = [
    new LowerTapeItem(
      name: 'Введите данные авто',
      description: 'Проверяйте и оплачивайте штрафы ГИБДД со скидкой 50%',
      color: '#3A72B5'.colorFromHex(),
      icon: Icons.traffic,
    ),
    new LowerTapeItem(
      name: 'Госпошлина со скидкой 30%',
      description:
          'Оплачивайте госпошлины на портале и экономьте. Скидка рассчитывается автоматически.',
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

  int get length => _items.length;

  void removeItemByName(String name) {
    _items.removeWhere((item) => item.name == name);
    notifyListeners();
  }

  LowerTapeItem getItem(int index) => _items[index];
}
