import 'package:flutter/material.dart';
import 'package:mvp_platform/widgets/common/buttons/Icon_button.dart';

typedef KeyboardTapCallback = void Function(String text);

class KeyboardUIConfig {
  final double digitSize;
  final double digitBorderWidth;
  final TextStyle digitTextStyle;
  final TextStyle deleteButtonTextStyle;
  final Color primaryColor;
  final Color digitFillColor;
  final EdgeInsetsGeometry keyboardRowMargin;
  final EdgeInsetsGeometry deleteButtonMargin;

  KeyboardUIConfig({
    this.digitSize = 80,
    this.digitBorderWidth = 1,
    this.keyboardRowMargin = const EdgeInsets.only(top: 15),
    this.primaryColor = Colors.white,
    this.digitFillColor = Colors.transparent,
    this.digitTextStyle = const TextStyle(fontSize: 30, color: Colors.white),
    this.deleteButtonMargin =
        const EdgeInsets.only(right: 25, left: 20, top: 15),
    this.deleteButtonTextStyle =
        const TextStyle(fontSize: 16, color: Colors.white),
  });
}

class Keyboard extends StatelessWidget {
  final KeyboardUIConfig keyboardUIConfig;
  final GestureTapCallback onDeleteCancelTap;
  final KeyboardTapCallback onKeyboardTap;
  final bool shouldShowCancel;
  final Widget cancelButton;
  final Widget deleteButton;
  final Widget fingerButton;

  //should have a proper order [1...9, 0]
  final List<String> digits;

  Keyboard({
    Key key,
    @required this.keyboardUIConfig,
    @required this.onDeleteCancelTap,
    @required this.onKeyboardTap,
    this.shouldShowCancel = true,
    @required this.cancelButton,
    @required this.deleteButton,
    @required this.fingerButton,
    this.digits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _buildKeyboard(context);

  Widget _buildKeyboard(BuildContext context) {
    List<String> keyboardItems = List.filled(10, '0');
    if (digits == null || digits.isEmpty) {
      keyboardItems = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
    } else {
      keyboardItems = digits;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: keyboardItems
                .sublist(0, 3)
                .map((e) => _buildKeyboardDigit(e))
                .toList()),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: keyboardItems
                .sublist(3, 6)
                .map((e) => _buildKeyboardDigit(e))
                .toList()),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: keyboardItems
                .sublist(6, 9)
                .map((e) => _buildKeyboardDigit(e))
                .toList()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildFingerAuth(context),
            _buildKeyboardDigit(keyboardItems[9]),
            _buildDeleteButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildKeyboardDigit(String text) {
    return Container(
      margin: keyboardUIConfig.keyboardRowMargin,
      width: keyboardUIConfig.digitSize,
      height: keyboardUIConfig.digitSize,
      child: ClipOval(
        child: Material(
          color: keyboardUIConfig.digitFillColor,
          child: InkWell(
            highlightColor: keyboardUIConfig.primaryColor,
            splashColor: keyboardUIConfig.primaryColor.withOpacity(0.4),
            onTap: () {
              onKeyboardTap(text);
            },
            child: Center(
              child: Text(
                text,
                style: keyboardUIConfig.digitTextStyle,
                semanticsLabel: text,
              ),
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: keyboardUIConfig.primaryColor,
            width: keyboardUIConfig.digitBorderWidth),
      ),
    );
  }

  Widget _buildFingerAuth(BuildContext context) {
    return Container(
      margin: keyboardUIConfig.keyboardRowMargin,
      width: keyboardUIConfig.digitSize,
      height: keyboardUIConfig.digitSize,
      child: ClipOval(
        child: Material(
          color: keyboardUIConfig.digitFillColor,
          child: InkWell(
            highlightColor: keyboardUIConfig.primaryColor,
            splashColor: keyboardUIConfig.primaryColor.withOpacity(0.4),
            onTap: () => Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    "Авторизация по отпечатку пальца не работает в демо приложении"),
              ),
            ),
            child: Center(
              child: IconSvg('assets/svg/fingerprint.svg'),
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: keyboardUIConfig.primaryColor,
            width: keyboardUIConfig.digitBorderWidth),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return Container(
      margin: keyboardUIConfig.keyboardRowMargin,
      height: keyboardUIConfig.digitSize,
      width: keyboardUIConfig.digitSize,
      child: ClipOval(
        child: Material(
          color: keyboardUIConfig.digitFillColor,
          child: InkWell(
            highlightColor: keyboardUIConfig.primaryColor,
            splashColor: keyboardUIConfig.primaryColor.withOpacity(0.4),
            onTap: onDeleteCancelTap,
            child: Center(
              child: shouldShowCancel ? cancelButton : deleteButton,
            ),
          ),
        ),
      ),
    );
  }
}
