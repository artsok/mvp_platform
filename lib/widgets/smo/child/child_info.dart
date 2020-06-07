import 'package:flutter/material.dart';
import 'package:mvp_platform/models/child.dart';
import 'package:mvp_platform/widgets/common/single_info_item.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';

class ChildInfo extends StatelessWidget {
  final Child child;

  ChildInfo(this.child, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: '#D4EEFD'.colorFromHex(),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleInfoItem(
              '№ свидетельства о рождении', child.birthCertificateId),
          SingleInfoItem('Фамилия', child.surname),
          SingleInfoItem('Имя', child.name),
          SingleInfoItem('Отчество', child.patronym),
          SingleInfoItem('Дата рождения', child.birthDate),
          SingleInfoItem('Место рождения', child.birthPlace.substring(0, 13),
              last: true),
        ],
      ),
    );
  }
}

class ActInfo extends StatelessWidget {
  final Child child;

  ActInfo(this.child, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: '#D4EEFD'.colorFromHex(),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleInfoItem('Фамилия, имя, отество', child.fullname),
          SingleInfoItem('Дата рождения', child.birthDate),
          SingleInfoItem('Место рождения', child.birthPlace),
          SingleInfoItem(
              'Запись акта о рождении', child.recordBirthCertificate),
          SingleInfoItem('Информация о родителях', child.parents),
          SingleInfoItem('Место гос.регистрации', "-"),
          SingleInfoItem('№ свидетельства о рождении', child.birthCertificateId),
          SingleInfoItem('Номер полиса ОМС', child.oms, last: true)
//          SingleInfoItem('СНИЛС', child.snils),
//          SingleInfoItem('Адрес проживания', child.address, last: true),
        ],
      ),
    );
  }
}
