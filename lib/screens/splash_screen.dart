import 'package:flutter/material.dart';
import 'package:mvp_platform/screens/auth_pin_code.dart';

import 'auth_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return isLandscape ? SplashPage(0.90, 0.15) : SplashPage(0.90, 0.05);
  }
}

class SplashPage extends StatelessWidget {
  static const routeName = '/splash-screen';
  final double maxWidth;
  final double maxHeight;

  SplashPage(this.maxWidth, this.maxHeight, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    checkUserAndNavigate(context).then((authenticated) {
      if (authenticated) {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } else {
        Navigator.pushReplacementNamed(context, AuthPinScreen.routeName);
      }
    });

    return Scaffold(
      body: LayoutBuilder(
        builder: (ctx, constraits) {
          final path = "assets/images/gos-main-logo.png";
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: constraits.maxWidth * maxWidth,
                    height: constraits.maxHeight * maxHeight,
                    child: Image.asset(path, fit: BoxFit.fitHeight),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future<bool> checkUserAndNavigate(BuildContext context) async {
    return new Future<bool>.delayed(
      const Duration(seconds: 2),
      () => false,
    );
  }
}
