import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvp_platform/models/child.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
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
          SingleInfoItem('Место рождения', child.birthPlace, last: true),
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

class ActInfo extends StatelessWidget {
  final Client child;

  ActInfo(this.child, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: '#D4EEFD'.colorFromHex(),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleInfoItem(
            'Фамилия, имя, отество',
            "${child.lastName} ${child.midName} ${child.lastName}",
          ),
          SingleInfoItem(
            'Дата рождения',
            DateFormat('dd.MM.yyyy').format(child.birthDate),
          ),
          SingleInfoItem(
            'Место рождения',
            child.birthPlace.getCountry() ?? '',
          ),
          SingleInfoItem(
            'Запись акта о рождении',
            "№ ${child.birthCertificate.series} ${child.birthCertificate.number == null ? '' : 'от ${child.birthCertificate.number}'}",
          ),
          SingleInfoItem(
            'Информация о родителях',
            child.parents.isEmpty ? '' : child.parents.toString(),
          ),
          SingleInfoItem('Место гос.регистрации', ''),
          SingleInfoItem(
            '№ свидетельства о рождении',
            child.birthAct?.getNumber() ?? '',
          ),
          SingleInfoItem(
            'Номер полиса ОМС',
            child.getPolicy()?.getNumber() ?? '',
            last: true,
          ),
//          SingleInfoItem('СНИЛС', child.snils),
//          SingleInfoItem('Адрес проживания', child.address, last: true),
        ],
      ),
    );
  }
}
