import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvp_platform/models/child.dart';
import 'package:mvp_platform/providers/children_provider.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/repository/response/dto/client/parent.dart';
import 'package:mvp_platform/widgets/common/single_info_item.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';

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
          SingleInfoItem('Место рождения',
              '${client.birthPlace.country} ${client.birthPlace.region}\n${client.birthPlace.city}'),
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
