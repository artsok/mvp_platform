import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp_platform/impl/pass/circle.dart';
import 'package:mvp_platform/impl/pass/keyboard.dart';
import 'package:mvp_platform/impl/pass/passcode_screen.dart';
import 'package:mvp_platform/screens/home_screen.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';
import 'package:mvp_platform/widgets/common/buttons/Icon_button.dart';

class PinScreen extends StatefulWidget {
  static const routeName = '/pin-screen';

  final String title;

  PinScreen({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PasscodeScreen(
        passwordDigits: 4,
        title: Column(
          children: [
            SizedBox(
              height: 100,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Positioned(
                    bottom: 50,
                    child: SvgPicture.asset("assets/svg/avatar.svg",
                        height: 50, width: 50),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      "Рекомендуем после входа \n добавить аватар",
                      softWrap: true,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Введите установленный код доступа',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
          ],
        ),
        //titleColor: Colors.grey,
        circleUIConfig: CircleUIConfig(
            borderColor: Colors.grey,
            fillColor: getGosBlueColor(),
            circleSize: 10),
        keyboardUIConfig: KeyboardUIConfig(
          digitBorderWidth: 1,
          primaryColor: Colors.white,
          deleteButtonTextStyle: TextStyle(color: Colors.grey, fontSize: 15),
          digitTextStyle: TextStyle(fontSize: 38, color: getGosBlueColor()),
        ),
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
