import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/impl/pass/keyboard.dart';
import 'package:mvp_platform/impl/pass/passcode_screen.dart';
import 'package:mvp_platform/screens/home_screen.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/common/buttons/Icon_button.dart';
import 'package:passcode_screen/circle.dart';


import 'package:flutter_svg/flutter_svg.dart';

class AuthPinScreen extends StatefulWidget {
  static const routeName = '/auth-pin-screen';

  AuthPinScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => _AuthPinScreenState();
}

class _AuthPinScreenState extends State<AuthPinScreen> {
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PasscodeScreen(
        passwordDigits: 4,
        title: Text("Введите установленный код доступа"),
        //titleColor: Colors.grey,
        circleUIConfig: CircleUIConfig(
            borderColor: getGosBlueColor(),
            fillColor: getGosBlueColor(),
            circleSize: 10),
        keyboardUIConfig: KeyboardUIConfig(
            digitBorderWidth: 1,
            primaryColor: Colors.white,
            deleteButtonTextStyle: TextStyle(color: Colors.grey, fontSize: 15),
            digitTextStyle: TextStyle(fontSize: 38, color: getGosBlueColor())),
        passwordEnteredCallback: _onPasscodeEntered,
        cancelButton: IconSvg('assets/svg/backspace-arrow.svg'),
        deleteButton: IconSvg('assets/svg/backspace-arrow.svg'),
        fingerButton: IconSvg('assets/svg/backspace-arrow.svg'),
        shouldTriggerVerification: _verificationNotifier.stream,
        backgroundColor: Colors.white,
        cancelCallback: _onPasscodeCancelled,
      ),
    );
  }

  _showLockScreen(BuildContext context,
      {bool opaque,
      CircleUIConfig circleUIConfig,
      KeyboardUIConfig keyboardUIConfig}) {
    Navigator.push(
        context,
        PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (context, animation, secondaryAnimation) =>
              PasscodeScreen(
            title: Text('Enter App Passcode'),
            circleUIConfig: circleUIConfig,
            keyboardUIConfig: keyboardUIConfig,
            passwordEnteredCallback: _onPasscodeEntered,
            cancelButton: Text('Cancel'),
            deleteButton: Text('Delete'),
            shouldTriggerVerification: _verificationNotifier.stream,
            backgroundColor: Colors.black.withOpacity(0.8),
            cancelCallback: _onPasscodeCancelled,
          ),
        ));
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = '1111' == enteredPasscode;
    _verificationNotifier.add(isValid);
    if (isValid) {
      setState(() {
        this.isAuthenticated = isValid;
      });
    }
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  _onPasscodeCancelled() {
    //Navigator.of(context).pushReplacement(Router.createRoute(LoginFaq()));
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }
}

