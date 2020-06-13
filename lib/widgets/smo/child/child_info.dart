import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvp_platform/models/child.dart';
import 'package:mvp_platform/providers/children_provider.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/repository/response/dto/client/parent.dart';
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

  String _concatText(List<String> list, String delimiter) {
    return list.join(delimiter);
  }

  @override
  Widget build(BuildContext context) {
    final Child child = Child(
        surname: client.lastName,
        name: client.firstName,
        patronym: client.midName,
        birthDate: DateFormat('dd.MM.yyyy').format(client.birthDate) ?? "",
        birthCertificateId:
            "серия ${client.birthCertificate.series} № ${client.birthCertificate.number}",
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
            "${client.lastName} ${client.firstName} ${client.midName}",
          ),
          SingleInfoItem(
            'Дата рождения',
            DateFormat('dd.MM.yyyy').format(client.birthDate),
          ),
          SingleInfoItem(
            'Место рождения',
            _concatText([
              client.birthPlace.getCountry(),
              client.birthPlace.getRegion(),
              '\n${client.getBirthPlace().getCity()}'
            ], ", "),
          ),
          SingleInfoItem(
            'Запись акта о рождении',
            "серия ${client.birthCertificate.series} № ${client.birthCertificate.number}",
          ),
          SingleInfoItem(
            'Информация о родителях',
            _parent(client.parents),
          ),
          SingleInfoItem(
              'Место гос.регистрации', client.birthAct.getBirthActPlace()),
          SingleInfoItem(
            '№ свидетельства о рождении',
            client.birthAct?.getNumber() ?? '',
            last: true,
          ),
//          SingleInfoItem('СНИЛС', child.snils),
//          SingleInfoItem('Адрес проживания', child.address, last: true),
        ],
      ),
    );
  }

  String _parent(List<Parent> parents) {
    if (parents.isEmpty) {
      return "";
    }

    List<String> formattedInfo = new List<String>();
    parents.forEach((element) {
      String parent = element.title +
          ": " +
          element.name +
          ", " +
          DateFormat('dd.MM.yyyy').format(element.birthDate) +
          ", " +
          element.nationality;
      formattedInfo.add(parent);
    });

    return formattedInfo.join("\n\n");
  }
}
