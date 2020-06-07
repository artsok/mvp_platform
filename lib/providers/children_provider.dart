import 'package:flutter/cupertino.dart';
import 'package:mvp_platform/models/child.dart';

class Children with ChangeNotifier {


  static final List<Child> children = [
    Child(
      birthCertificateId: 'серия NA-VI № 0347730',
      surname: 'Богатырев',
      name: 'Иван',
      patronym: 'Иванович',
      birthDate: "04.05.2020",
      snils: "533-573-394 97",
      birthPlace: "г.Калининград, Калининградская область, Россия",
      address: "г.Калининград, ул.Горького, д.26, кв.17",
      recordBirthCertificate: "№ от дд.мм.гггг",
      parents: "Отец: ФИО, Дата рождения, гражданство \nМать: Богатырева Елена Владимировна, 31.03.1985, РФ",
      oms: "6351240828000236"
    )
  ];
}