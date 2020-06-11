class BirthPlace {
  String country;
  String region;
  String county;
  String district;
  String city;

  BirthPlace.fromJson(Map<String, dynamic> json) {
    country = json['country'] != null ? json['country'] : null;
    region = json['region'] != null ? json['region'] : null;
    county = json['county'] != null ? json['county'] : null;
    district = json['district'] != null ? json['district'] : null;
    city = json['city'] != null ? json['city'] : null;
  }

  String getCountry() {
    return country;
  }

  void setCountry(String country) {
    this.country = country;
  }

  String getRegion() {
    return region;
  }

  void setRegion(String region) {
    this.region = region;
  }

  String getCounty() {
    return county;
  }

  void setCounty(String county) {
    this.county = county;
  }

  String getDistrict() {
    return district;
  }

  void setDistrict(String district) {
    this.district = district;
  }

  String getCity() {
    return city;
  }

  void setCity(String city) {
    this.city = city;
  }
}
