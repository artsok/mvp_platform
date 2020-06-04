import 'package:flutter/material.dart';
import 'package:mvp_platform/widgets/auth/auth_form.dart';
import 'package:mvp_platform/extensions/string_extensions.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth-screen';

  AuthScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AuthForm(),
      ),
    );
  }
}
