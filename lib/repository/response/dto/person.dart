class Person {
  String id;
  String firstName;
  String midName;
  String lastName;

  Person.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'] : null;
    firstName = json['firstName'] != null ? json['firstName'] : null;
    midName = json['lastName'] !=null ? json['lastName'] : null;
    lastName = json['lastName'] != null ? json['lastName'] : null;
  }

  Person() {}

  String getFirstName() {
    return firstName;
  }

  String getId() {
    return id;
  }

  void setId(String id) {
    this.id = id;
  }

  void setFirstName(String firstName) {
    this.firstName = firstName;
  }

  String getMidName() {
    return midName;
  }

  void setMidName(String midName) {
    this.midName = midName;
  }

  String getLastName() {
    return lastName;
  }

  void setLastName(String lastName) {
    this.lastName = lastName;
  }

  Person.all(String id, String firstName, String midName, String lastName) {
    this.id = id;
    this.firstName = firstName;
    this.midName = midName;
    this.lastName = lastName;
  }

  Person.withId(String id) {
    this.id = id;
  }

  @override
  String toString() {
    return 'Person{id: $id, firstName: $firstName, midName: $midName, lastName: $lastName}';
  }
}
