import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/utils/assets_utils.dart';

import 'client/policy.dart';

class Person extends ChangeNotifier {
  String id;
  String firstName;
  String midName;
  String lastName;
  String photoPath;
  Policy policy;
  String snils;
  DateTime birthDate;
  String phone;
  String email;

  Person.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'] : null;
    firstName = json['firstName'] != null ? json['firstName'] : null;
    midName = json['midName'] != null ? json['midName'] : null;
    lastName = json['lastName'] != null ? json['lastName'] : null;
    policy = json['policy'] != null ? Policy.fromJson(json['policy']) : null;
    snils = json['snils'] != null ? json['snils'] : null;
    birthDate =
        json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null;
    phone = json['phone'] != null ? json['phone'] : null;
    email = json['email'] != null ? json['email'] : null;
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

  Person();

  @override
  String toString() {
    return 'Person{id: $id, firstName: $firstName, midName: $midName, lastName: $lastName}';
  }

  String get fullName => '$lastName $firstName $midName';

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
