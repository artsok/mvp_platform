class Identity {
  String type;
  String series;
  String number;

  Identity.fromJson(Map<String, dynamic> json) {
    type = json['type'] != null ? json['type'] : null;
    series = json['series'] != null ? json['series'] : null;
    number = json['number'] != null ? json['number'] : null;
  }

  String getType() {
    return type;
  }

  void setType(String type) {
    this.type = type;
  }

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
}
