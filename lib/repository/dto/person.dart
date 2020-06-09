import 'package:dataclass/dataclass.dart';

class Person {
  String id;
  String firstName;
  String midName;
  String lastName;

  Person({String id, String firstName, String midName, String lastName}) {
    this.id = id;
    this.firstName = firstName;
    this.midName = midName;
    this.lastName = lastName;
  }

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
}
