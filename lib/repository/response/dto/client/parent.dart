class Parent {
  String title;
  String firstName;
  String midName;
  String lastName;
  DateTime birthDate;
  String nationality;

  Parent.fromJson(Map<String, dynamic> json) {
    title = json['title'] != null ? json['title'] : null;
    firstName = json['firstName'] != null ? json['firstName'] : null;
    midName = json['midName'] != null ? json['midName'] : null;
    lastName = json['lastName'] != null ? json['lastName'] : null;
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
    return 'Parent{title: $title, firstName: $firstName, lastName: $lastName, birthDate: $birthDate, nationality: $nationality}';
  }
}
