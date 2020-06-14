import 'package:flutter/material.dart';
import 'package:mvp_platform/models/child.dart';
import 'package:mvp_platform/providers/children_provider.dart';
import 'package:mvp_platform/repository/response/dto/client.dart';
import 'package:mvp_platform/repository/response/dto/client/parent.dart';
import 'package:mvp_platform/utils/extensions/datetime_extensions.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/common/single_info_item.dart';

class ActInfo extends StatelessWidget {
  final Client client;

  ActInfo(this.client, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Child child = Child(
        surname: client.lastName,
        name: client.firstName,
        patronym: client.midName,
        birthDate: client.birthDate.toDmy() ?? '',
        birthCertificateId:
            'серия ${client.birthCertificate.series} № ${client.birthCertificate.number}',
        birthPlace: 'г.Калининград, Калининградская область, Россия');

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
            client.fullName,
          ),
          SingleInfoItem(
            'Дата рождения',
            client.birthDate?.toDmy() ?? 'не указана',
          ),
          SingleInfoItem('Место рождения',
              '${client.birthPlace.country} ${client.birthPlace.region}\n${client.birthPlace.city}'),
          SingleInfoItem(
            'Запись акта о рождении',
            '${client.birthAct?.number} от ${client.birthAct.date.toDmy()}',
          ),
          SingleInfoItem(
            'Информация о родителях',
            _parents(client.parents),
          ),
          SingleInfoItem(
              'Место гос.регистрации', client.birthAct.getBirthActPlace()),
          SingleInfoItem(
            '№ свидетельства о рождении',
            "серия ${client.birthCertificate.series} № ${client.birthCertificate.number}",
            last: true,
          ),
//          SingleInfoItem('СНИЛС', child.snils),
//          SingleInfoItem('Адрес проживания', child.address, last: true),
        ],
      ),
    );
  }

  String _parents(List<Parent> parents) => parents.isEmpty
      ? ''
      : parents
          .map((p) =>
              '${p.title}: ${p.lastName} ${p.midName} ${p.firstName}, ${p.birthDate.toDmy()}, ${p.nationality}')
          .toList()
          .join('\n\n');
}
