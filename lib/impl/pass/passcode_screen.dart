import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvp_platform/impl/pass/circle.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';

import 'package:mvp_platform/impl/pass/shake_curve.dart';

import 'keyboard.dart';

typedef PasswordEnteredCallback = void Function(String text);
typedef IsValidCallback = void Function();
typedef CancelCallback = void Function();

class PasscodeScreen extends StatefulWidget {
  final Widget title;
  final int passwordDigits;
  final Color backgroundColor;
  final PasswordEnteredCallback passwordEnteredCallback;

  //isValidCallback will be invoked after passcode screen will pop.
  final IsValidCallback isValidCallback;
  final CancelCallback cancelCallback;

  // Cancel button and delete button will be switched based on the screen state
  final Widget cancelButton;
  final Widget deleteButton;
  final Widget fingerButton;
  final Stream<bool> shouldTriggerVerification;
  final Widget bottomWidget;
  final CircleUIConfig circleUIConfig;
  final KeyboardUIConfig keyboardUIConfig;
  final List<String> digits;

  PasscodeScreen({
    Key key,
    @required this.title,
    this.passwordDigits = 6,
    @required this.passwordEnteredCallback,
    @required this.cancelButton,
    @required this.deleteButton,
    @required this.fingerButton,
    @required this.shouldTriggerVerification,
    this.isValidCallback,
    this.circleUIConfig,
    this.keyboardUIConfig,
    this.bottomWidget,
    this.backgroundColor,
    this.cancelCallback,
    this.digits,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PasscodeScreenState();
}

class _PasscodeScreenState extends State<PasscodeScreen>
    with SingleTickerProviderStateMixin {
  StreamSubscription<bool> streamSubscription;
  String enteredPasscode = '';
  AnimationController controller;
  Animation<double> animation;

  @override
  initState() {
    super.initState();
    streamSubscription = widget.shouldTriggerVerification
        .listen((isValid) => _showValidation(isValid));
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final Animation curve =
        CurvedAnimation(parent: controller, curve: ShakeCurve());
    animation = Tween(begin: 0.0, end: 10.0).animate(curve)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            enteredPasscode = '';
            controller.value = 0;
          });
        }
      })
      ..addListener(() {
        setState(() {
          // the animation object’s value is the changed state
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor ?? Colors.black.withOpacity(0.8),
      body:
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            widget.title,
            Container(
              margin: const EdgeInsets.only(left: 150, right: 150),
              //width: 100,
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _buildCircles(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 96),
              child: Container(child: Text("Сбросить код доступа", style: TextStyle(color: getGosBlueColor(), fontWeight: FontWeight.w300),)),
            ),
            Column(
                  children: [
                    IntrinsicHeight(
                      child: Container(
                        margin: const EdgeInsets.only(top: 20, left: 40, right: 40),
                        child: Keyboard(
                          onDeleteCancelTap: _onDeleteCancelButtonPressed,
                          onKeyboardTap: _onKeyboardButtonPressed,
                          shouldShowCancel: enteredPasscode.length == 0,
                          cancelButton: widget.cancelButton,
                          deleteButton: widget.deleteButton,
                          fingerButton: widget.fingerButton,
                          keyboardUIConfig: widget.keyboardUIConfig != null
                              ? widget.keyboardUIConfig
                              : KeyboardUIConfig(),
                          digits: widget.digits,
                        ),
                      ),
                    ),
                  ],
                ),
            widget.bottomWidget != null ? widget.bottomWidget : Container()
          ],
        ),
    );
  }

  List<Widget> _buildCircles() {
    var list = <Widget>[];
    var config = widget.circleUIConfig != null
        ? widget.circleUIConfig
        : CircleUIConfig();
    config.extraSize = animation.value;
    for (int i = 0; i < widget.passwordDigits; i++) {
      list.add(Circle(
        filled: i < enteredPasscode.length,
        circleUIConfig: config,
      ));
    }
    return list;
  }

  _onDeleteCancelButtonPressed() {
    if (enteredPasscode.length > 0) {
      setState(() {
        enteredPasscode =
            enteredPasscode.substring(0, enteredPasscode.length - 1);
      });
    } else {
      if (widget.cancelCallback != null) {
        widget.cancelCallback();
      }
    }
  }

  _onKeyboardButtonPressed(String text) {
    setState(() {
      if (enteredPasscode.length < widget.passwordDigits) {
        enteredPasscode += text;
        if (enteredPasscode.length == widget.passwordDigits) {
          widget.passwordEnteredCallback(enteredPasscode);
        }
      }
    });
  }

  @override
  didUpdateWidget(PasscodeScreen old) {
    super.didUpdateWidget(old);
    // in case the stream instance changed, subscribe to the new one
    if (widget.shouldTriggerVerification != old.shouldTriggerVerification) {
      streamSubscription.cancel();
      streamSubscription = widget.shouldTriggerVerification
          .listen((isValid) => _showValidation(isValid));
    }
  }

  @override
  dispose() {
    controller.dispose();
    streamSubscription.cancel();
    super.dispose();
  }

  _showValidation(bool isValid) {
    if (isValid) {
      //Navigator.maybePop(context).then((pop) => _validationCallback());
    } else {
      controller.forward();
    }
  }

  _validationCallback() {
    if (widget.isValidCallback != null) {
      widget.isValidCallback();
    } else {
      print(
          "You didn't implement validation callback. Please handle a state by yourself then.");
    }
  }
}
