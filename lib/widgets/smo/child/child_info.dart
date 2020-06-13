import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvp_platform/models/child.dart';
import 'package:mvp_platform/providers/children_provider.dart';
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
  final Client client;

  ActInfo(this.client, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Child child = Child(
        surname: client.lastName,
        name: client.firstName,
        patronym: client.midName,
        birthDate: DateFormat('dd.MM.yyyy').format(client.birthDate) ?? "",
        birthCertificateId:
            "№ ${client.birthCertificate.series} от ${client.birthCertificate.number}",
        birthPlace: "г.Калининград, Калининградская область, Россия");

    if (Children.children.length == 0) {
      Children.children.add(child);
    }

    return Container(
      color: '#D4EEFD'.colorFromHex(),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleInfoItem(
            'Номер полиса ОМС',
            client.getPolicy()?.getNumber() ?? '',
            last: true,
          ),
          SingleInfoItem(
            'Фамилия, имя, отество',
            "${client.lastName} ${client.midName} ${client.lastName}",
          ),
          SingleInfoItem(
            'Дата рождения',
            DateFormat('dd.MM.yyyy').format(client.birthDate),
          ),
          SingleInfoItem(
            'Место рождения',
            client.birthPlace.getCountry() ?? '',
          ),
          SingleInfoItem(
            'Запись акта о рождении',
            "№ ${client.birthCertificate.series} ${client.birthCertificate.number == null ? '' : 'от ${client.birthCertificate.number}'}",
          ),
          SingleInfoItem(
            'Информация о родителях',
            client.parents.isEmpty ? '' : client.parents.toString(),
          ),
          SingleInfoItem('Место гос.регистрации', ''),
          SingleInfoItem(
            '№ свидетельства о рождении',
            client.birthAct?.getNumber() ?? '', last: true,
          ),
//          SingleInfoItem('СНИЛС', child.snils),
//          SingleInfoItem('Адрес проживания', child.address, last: true),
        ],
      ),
    );
  }
}
