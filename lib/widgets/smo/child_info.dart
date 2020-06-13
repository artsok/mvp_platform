import 'package:flutter/material.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/utils/extensions/datetime_extensions.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/common/single_info_item.dart';

class ChildInfo extends StatelessWidget {
  final Client child;

  ChildInfo(this.child, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: '#D4EEFD'.colorFromHex(),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleInfoItem('№ свидетельства о рождении',
              child.birthAct?.getNumber() ?? 'нет'),
          SingleInfoItem('Фамилия', child.lastName),
          SingleInfoItem('Имя', child.firstName),
          SingleInfoItem('Отчество', child.midName),
          SingleInfoItem('Дата рождения', child.birthDate.toDmy()),
          SingleInfoItem('Место рождения',
              '${child.birthPlace.country} ${child.birthPlace.region}\n${child.birthPlace.city}',
              last: true),
        ],
      ),
    );
  }
}

//class ActInfo extends StatelessWidget {
//  final Child child;
//
//  ActInfo(this.child, {Key key}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      color: '#D4EEFD'.colorFromHex(),
//      width: double.infinity,
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          SingleInfoItem('Фамилия, имя, отество', child.fullname),
//          SingleInfoItem('Дата рождения', child.birthDate),
//          SingleInfoItem('Место рождения', child.birthPlace),
//          SingleInfoItem(
//              'Запись акта о рождении', child.recordBirthCertificate),
//          SingleInfoItem('Информация о родителях', child.parents),
//          SingleInfoItem('Место гос.регистрации', child.gosRegistration),
//          SingleInfoItem(
//              '№ свидетельства о рождении', child.birthCertificateId),
//          SingleInfoItem('Номер полиса ОМС', child.oms, last: true)
////          SingleInfoItem('СНИЛС', child.snils),
////          SingleInfoItem('Адрес проживания', child.address, last: true),
//        ],
//      ),
//    );
//  }
//}
