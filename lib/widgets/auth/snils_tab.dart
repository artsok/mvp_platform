import 'package:flutter/material.dart';
import 'package:mvp_platform/screens/home_screen.dart';
import 'package:mvp_platform/widgets/common/gos_button.dart';

class SnilsTab extends StatefulWidget {

  static const tabName = 'СНИЛС';

  @override
  _SnilsTabState createState() => _SnilsTabState();
}

class _SnilsTabState extends State<SnilsTab> {

  String snils;
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
                hintText: 'СНИЛС',
                icon: Icon(
                  Icons.description,
                  color: Colors.grey,
                ),
              ),
              validator: (value) =>
              value.isEmpty ? 'Email can\'t be empty' : null,
              onSaved: (value) => snils = value.trim(),
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
