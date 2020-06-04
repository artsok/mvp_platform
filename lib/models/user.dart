import 'package:flutter/foundation.dart';

class User {
  final String _name;
  String _email;
  String _phoneNumber;
  String _password;

  User({
    @required String name,
    @required String email,
    @required String phoneNumber,
    @required String password,
  })  : this._name = name,
        this._email = email,
        this._phoneNumber = phoneNumber,
        this._password = password;

  String get name => _name;

  String get email => _email;

  String get phoneNumber => _phoneNumber;

  String get password => _password;

  set email(String email) => this._email = email;

  set phoneNumber(String phoneNumber) => this._phoneNumber = phoneNumber;

  set password(String password) => this._password = password;
}
