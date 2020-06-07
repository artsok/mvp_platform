import 'package:flutter/material.dart';
import 'package:mvp_platform/providers/user_auth_provider.dart';
import 'package:mvp_platform/screens/auth_screen.dart';
import 'package:mvp_platform/screens/home_screen.dart';
import 'package:mvp_platform/screens/pin_screen.dart';

class RootScreen extends StatefulWidget {
  static const routeName = '/root-screen';

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  UserAuth auth = UserAuth();

  @override
  void initState() {
    super.initState();
    auth.authenticate().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return auth.authenticated ? HomeScreen() : PinScreen();
  }
}
