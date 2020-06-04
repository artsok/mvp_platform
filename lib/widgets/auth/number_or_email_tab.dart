import 'package:flutter/material.dart';
import 'package:mvp_platform/screens/home_screen.dart';
import 'package:mvp_platform/widgets/common/gos_button.dart';

class NumberOrEmailTab extends StatefulWidget {
  static const tabName = 'Телефон или почта';

  NumberOrEmailTab({Key key}) : super(key: key);

  @override
  _NumberOrEmailTabState createState() => _NumberOrEmailTabState();
}

class _NumberOrEmailTabState extends State<NumberOrEmailTab> {
  String number;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Мобильный телефон или почта',
                icon: Icon(
                  Icons.phonelink,
                  color: Colors.grey,
                ),
              ),
              validator: (value) =>
                  value.isEmpty ? 'Email can\'t be empty' : null,
              onSaved: (value) => email = value.trim(),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: TextFormField(
              maxLines: 1,
              obscureText: true,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Пароль',
                icon: Icon(
                  Icons.lock,
                  color: Colors.grey,
                ),
              ),
              validator: (value) =>
                  value.isEmpty ? 'Password must not be empty' : null,
              onSaved: (value) => password = value.trim(),
            ),
          ),
        ],
      ),
    );
  }
}
