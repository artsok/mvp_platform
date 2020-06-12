class Parent {
  String title;
  String name;
  DateTime birthDate;
  String nationality;

  Parent.fromJson(Map<String, dynamic> json) {
    title = json['title'] != null ? json['title'] : null;
    name = json['name'] != null ? json['name'] : null;
    birthDate =
        json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null;
    nationality = json['nationality'] != null ? json['nationality'] : null;
  }

  String getTitle() {
    return title;
  }

  void setTitle(String title) {
    this.title = title;
  }

  String getName() {
    return name;
  }

  void setName(String name) {
    this.name = name;
  }

  DateTime getBirthDate() {
    return birthDate;
  }

  void setBirthDate(DateTime birthDate) {
    this.birthDate = birthDate;
  }

  String getNationality() {
    return nationality;
  }

  void setNationality(String nationality) {
    this.nationality = nationality;
  }

  @override
  String toString() {
    return 'Parent{title: $title, name: $name, birthDate: $birthDate, nationality: $nationality}';
  }
}
