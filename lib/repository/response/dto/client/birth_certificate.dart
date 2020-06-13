class BirthCertificate {
  String series;
  String number;
  DateTime date;

  String getSeries() {
    return series;
  }

  void setSeries(String series) {
    this.series = series;
  }

  String getNumber() {
    return number;
  }

  void setNumber(String number) {
    this.number = number;
  }

  DateTime getDate() {
    return date;
  }

  void setDate(DateTime date) {
    this.date = date;
  }

  BirthCertificate.fromJson(Map<String, dynamic> json) {
    series = json['series'] != null ? json['series'] : null;
    number = json['number'] != null ? json['number'] : null;
    date = json['date'] != null ? DateTime.parse(json['date']) : null;
  }
}
