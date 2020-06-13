class BirthAct {
  String number;
  DateTime date;
  String birthActPlace;

  String getNumber() {
    return number;
  }

  void setNumber(String number) {
    this.number = number;
  }

  String getBirthActPlace() {
    return birthActPlace;
  }

  void setBirthActPlace(String birthActPlace) {
    this.birthActPlace = birthActPlace;
  }

  DateTime getDate() {
    return date;
  }

  void setDate(DateTime date) {
    this.date = date;
  }

  BirthAct.fromJson(Map<String, dynamic> json) {
    number = json['number'] != null ? json['number'] : null;
    date = json['date'] != null ? DateTime.parse(json['date']) : null;
    birthActPlace =
        json['birthActPlace'] != null ? json['birthActPlace'] : null;
  }
}
