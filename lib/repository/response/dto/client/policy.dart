import 'package:mvp_platform/repository/response/dto/client/representative.dart';

class Policy {
  String series;
  String number;
  String territory;
  String smoCode;
  String smoName;
  String startDate;
  String endDate;
  Representative representative;

  Policy.fromJson(Map<String, dynamic> json) {
    series = json['series'] != null ? json['series'] : null;
    number = json['number'] != null ? json['number'] : null;
    territory = json['territory'] != null ? json['territory'] : null;
    smoCode = json['smoCode'] != null ? json['smoCode'] : null;
    startDate = json['startDate'] != null ? json['startDate'] : null;
    endDate = json['endDate'] != null ? json['endDate'] : null;
    representative = json['representative'] != null
        ? Representative.fromJson(json['representative'])
        : null;
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

  String getTerritory() {
    return territory;
  }

  void setTerritory(String territory) {
    this.territory = territory;
  }

  String getSmoCode() {
    return smoCode;
  }

  void setSmoCode(String smoCode) {
    this.smoCode = smoCode;
  }

  String getSmoName() {
    return smoName;
  }

  void setSmoName(String smoName) {
    this.smoName = smoName;
  }

  String getStartDate() {
    return startDate;
  }

  void setStartDate(String startDate) {
    this.startDate = startDate;
  }

  String getEndDate() {
    return endDate;
  }

  void setEndDate(String endDate) {
    this.endDate = endDate;
  }

  Representative getRepresentative() {
    return representative;
  }

  void setRepresentative(Representative representative) {
    this.representative = representative;
  }

  Policy.withSeriesNumberTerritory(
      String series, String number, String territory) {
    this.series = series;
    this.number = number;
    this.territory = territory;
  }

  Policy();
}
